#
# Cookbook Name:: bondage
# Recipe:: bonds
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

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
case node[:platform]
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
