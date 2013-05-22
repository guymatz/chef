#
# Cookbook Name:: monitoring
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Figure out what kind of system we've got here apply monitoring utils as appriopriate
include_recipe "snmp"
unless node[:fqdn].include? "use1b"
  unless node[:dmi][:system][:manufacturer].nil?
    puts "Detected manufacturer " + node[:dmi][:system][:manufacturer]
    case node[:dmi][:system][:manufacturer]
    when "VMware, Inc."
      include_recipe "vmware-tools"
    when "Dell Inc."
      include_recipe "monitoring::dell"
    end
  else
    puts "Unable to detect system-manufacturer"
  end
end
