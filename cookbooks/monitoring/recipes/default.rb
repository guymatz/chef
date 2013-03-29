#
# Cookbook Name:: monitoring
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Figure out what kind of system we've got here apply monitoring utils as appriopriate

# Check for VMware
begin
  if node['system']['virtualization'] == 'vmware'
    include_recipe "vmware-tools"
  end
  rescue NoMethodError
end

# Check for Dell
begin
  if node['system']['Manufacturer']== "Dell, Inc"
    include_recipe "monitoring::dell"
  end
  rescue NoMethodError
end
