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

begin
  Chef::Log.info("Creating modprobe-config: 8021q")
  modules "8021q" do
    action :save
  end
end

# so if w're on a dell, we want to bond em2 and p2p1
# if we're on vmware, we should use eth2 without bonding

unless node[:dmi][:system][:manufacturer].nil?
  case node[:dmi][:system][:manufacturer]
  when "VMware, Inc."
    sys_type = "vmware"
    return # just bag doing anything for now
  when "Dell Inc."
    sys_type = "dell"
    master_intf = "bond0"
    slave_intfs = %w{ em2 p2p1 }
  end
else
  puts "Unable to detect system-manufacturer"
  return
end

# okay, who's gonna be the Dom?
case node['platform']
when "centos"
  if sys_type == "dell"

    # Dell Systems running Centos
    template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}" do
      source "ifcfg-master.erb"
      mode 0644
      owner "root"
      group "root"
      variables({
                  :master => master_intf
                })
    end

    # put Mr. Slave on the box
    slave_intfs.each do |s|
      template "/etc/sysconfig/network-scripts/ifcfg-#{s}" do
        source "ifcfg-slave.erb"
        owner "root"
        group "root"
        mode "0644"
        variables({
                    :device => s,
                    :master => master_intf
                  })
      end

    end
  end
end


node[:fqdn] =~ /(\w*-\w*\d*)(\..*)$/
shortname = $1
domain = $2

res = Net::DNS::Resolver.new
ihrzone = res.axfr 'ihr'

interfaces = Array.new

# be careful, this thinks every IP is a /32 address, to_s will strip it
ihrzone.answer.each do |rr|
  if rr.type == 'A' and rr.name.include? shortname + "-v"
    rr.name =~ /(\w*-\w*\d*)-v(\d*)(\..*)$/
    interfaces.push({
                      :ip => rr.address.to_s,
                      :vlan => $2
                    })
  end
end

if interfaces.nil? or interfaces.count == 0
  Chef::Log.info("No tagged interfaces found in dns for " + shortname)
  return
end

puts "We're going to setup:\n" + interfaces.inspect

case node['platform']
when "centos"
  interfaces.each do |intf|
    Chef::Log.info("Setting up: " + intf.inspect)
    template "/etc/sysconfig/network-scripts/ifcfg-#{master_intf}.#{intf[:vlan]}" do
      source "ifcfg-bond.vlan.erb"
      owner "root"
      group "root"
      mode "0644"
      variables ({
                   :ip => intf[:ip],
                   :device => master_intf,
                   :vlan => intf[:vlan],
                   :netmask => '255.255.254.0'
                 })
    end
  end
end
