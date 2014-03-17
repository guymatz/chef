#
# Cookbook Name:: jobserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::jobserver"
include_recipe "users::jobserver-sudo"
include_recipe "jobserver::update_es_index"

if node.chef_environment == 'prod'
  include_recipe "jobserver::ha"
end

service "nagios-nrpe-server"
nagios_nrpecheck "Process-Cron" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  critical_condition "1:"
  parameters "-C crond"
  action :add
end

cron_d "fbconsumer_log_cleanup" do
  hour "22"
  command 'find /data/log/facebook-consumer* -type f -mtime +30 -exec rm -rf {} \;'
end


# Things that should run on the jobserver
#### Keep them organized by the Application(cookbook) that they belong to.
#### When adding jobs, include the JIRA ticket number in the comments
#### so we can track them easily.

if node.chef_environment == "prod"
  include_recipe "jobserver::fac"
  include_recipe "jobserver::tophit"
end
