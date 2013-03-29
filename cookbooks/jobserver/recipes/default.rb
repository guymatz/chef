#
# Cookbook Name:: jobserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node.chef_environment == 'prod'
  include_recipe "jobserver::ha"
end

nagios_nrpecheck "Check-Cron" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C crond"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
