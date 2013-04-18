#
# Cookbook Name:: bondage
# Recipe:: bonds
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "bondage::default"

chef_gem "net-dns" do
  action :install
end

require 'socket'
require 'rubygems'
require 'net/dns'

# so if w're on a dell, we want to bond em2 and p2p1
# if we're on vmware, we should use eth2 without bonding

unless node[:dmi][:system][:manufacturer].nil?
  case node[:dmi][:system][:manufacturer]
  when "VMware, Inc."
    sys_type = "vmware"
    master_intf = "eth1"
  when "Dell Inc."
    sys_type = "dell"
    master_intf = "bond0"
    slave_intfs = %w{ em2 p2p1 }
  end
else
  puts "Unable to detect system-manufacturer"
  return
end

node[:fqdn] =~ /(\w*-\w*\d*)(\..*)$/
shortname = $1
domain = $2

res = Net::DNS::Resolver.new
ihrzone = res.axfr 'ihr'

interfaces = Array.new
tagged_interfaces = Array.new

# be careful, this thinks every IP is a /32 address, to_s will strip it
shortname =~ /(\w*-\w*\d{3})([ab]{0,1})/
unless $1 == shortname
  vip_name = $1
end

ihrzone.answer.each do |rr|
  # skip, we just want A records
  next if rr.name == 'ihr.'
  next if rr.type != 'A'

  if rr.type == 'A' and rr.name.include? shortname + "-v"
    rr.name =~ /(\w*-\w*\d*)-v(\d*)(\..*)$/
    interfaces.push({
                      :ip => rr.address.to_s,
                      :vlan => $2
                    })
  elsif defined? vip_name and vip_name.to_s.length > 4         # ".ihr." -> 5
    puts "VIPNAME: (#{vip_name})"
    if rr.name.include? vip_name + "-v"
      rr.name =~ /(\w*-\w*\d{3})-v(\d*)(\..*)/
      interfaces.push({
                        :ip => rr.address.to_s,
                        :vlan => $2
                      })
      tagged_interfaces.push({
                               :ip => rr.address.to_s,
                               :vlan => $2
                             })
    end
  end
end

if interfaces.nil? or interfaces.count == 0
  Chef::Log.info("No tagged interfaces found in dns for " + shortname)
  return
end

puts "We're going to setup:\n" + interfaces.inspect

case node[:platform]
when "centos"
  file "/etc/sysconfig/modules/8021q.modules" do
    content "modprobe 8021q"
    owner "root"
    group "root"
  end

  interfaces.each do |intf|
    Chef::Log.info("Setting up: " + intf.inspect)
    service "network" do
      action :nothing
      supports :restart => true
      provider Chef::Provider::Service::Init
    end
    if sys_type == "dell"
      template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}.#{intf[:vlan]}" do
        source "ifcfg-bond.vlan.erb"
        owner "root"
        group "root"
        mode "0755"
        variables ({
                     :ip => intf[:ip],
                     :device => master_intf,
                     :vlan => intf[:vlan],
                     :netmask => '255.255.254.0'
                   })
        not_if "test -f /etc/sysconfig/network-scripts/ifcfg-#{master_intf}.#{intf[:vlan]}" || node.normal.attribute?('whipped')
        notifies :restart, "service[network]"
      end
    elsif sys_type == "vmware"
      template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}" do
        source "ifcfg-intf.erb"
        owner "root"
        group "root"
        mode "0755"
        variables ({
                     :device => master_intf
                   })
        not_if "test -f /etc/sysconfig/network-scripts/ifcfg-#{master_intf}" || node.normal.attribute?('whipped')
        notifies :restart, "service[network]"
      end

      template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}.#{intf[:vlan]}" do
        source "ifcfg-intf-vlan.erb"
        owner "root"
        group "root"
        mode "0755"
        variables ({
                     :ip => intf[:ip],
                     :device => master_intf,
                     :vlan => intf[:vlan],
                     :netmask => '255.255.254.0'
                   })
        not_if { node.normal.attribute?('whipped') }
        notifies :restart, "service[network]"
      end
    end

    if intf[:vlan] == "200"
      Chef::Log.info("Adjusting Default GW to PROD")
      ruby_block "Setup PROD Default GW" do
        block do
          file = Chef::Util::FileEdit.new("/etc/sysconfig/network")
          file.insert_line_if_no_match("/GATEWAY=10.5.40.1/", "GATEWAY=10.5.40.1")
          file.write_file
        end
        not_if { node.normal.attribute?('whipped') }
        notifies :restart, "service[network]"
      end
    end

  end

  tagged_interfaces.each do |intf|
    vip_netmask = '255.255.254.0'
    template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}" do
      source "ifcfg-intf.erb"
      user "root"
      group "root"
      mode "0755"
      variables ({
                   :device => master_intf
                 })
    end
    if node.has_key? 'heartbeat'
      if sys_type == "vmware"
        Chef::Log.info("Creating Heartbeat Config: IPaddr::#{intf[:ip]}/#{vip_netmask}/#{master_intf}")
        node.set[:heartbeat][:ha_resources]["#{master_intf}_#{intf[:vlan]}"] = "IPaddr::#{intf[:ip]}/#{vip_netmask}/#{master_intf}.#{intf[:vlan]}"
      else
        Chef::Log.info("Creating Heartbeat Config: IPaddr::#{intf[:ip]}/#{vip_netmask}/#{master_intf}")
        node.set[:heartbeat][:ha_resources]["#{master_intf}_#{intf[:vlan]}"] = "IPaddr::#{intf[:ip]}/#{vip_netmask}/#{master_intf}"
      end
      node.save
    end
  end
end

node.set['whipped'] = true
node.save
