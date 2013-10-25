#
# Cookbook Name:: amp
# Recipe:: nagios
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

service "nagios-nrpe-server" do
  supports :start => true, :stop => true, :status => true
end

template "#{node[:nagios][:plugin_dir]}/extended-alert.sh" do
  source "extended-alert.sh.erb"
  owner node[:nagios][:user]
  group node[:nagios][:group]
  mode "755"
end

nagios_nrpecheck "Amp-Extended-Logs" do
  command "#{node[:nagios][:plugin_dir]}/extended-alert.sh"
  warning_condition "5"
  critical_condition "10"
  action :add
end

template "#{node[:nagios][:plugin_dir]}/extended-alert-500.sh" do
  source "extended-alert-500.sh.erb"
  owner node[:nagios][:user]
  group node[:nagios][:group]
  mode "755"
end

nagios_nrpecheck "Amp-Extended-500-Logs" do
  command "#{node[:nagios][:plugin_dir]}/extended-alert-500.sh"
  warning_condition "5"
  critical_condition "10"
  action :add
end

template "#{node[:nagios][:plugin_dir]}/extended-alert-mean-response.sh" do
  source "extended-alert-mean-response.sh.erb"
  owner node[:nagios][:user]
  group node[:nagios][:group]
  mode "755"
end

nagios_nrpecheck "Amp-Extended-Mean-Response" do
  command "#{node[:nagios][:plugin_dir]}/extended-alert-mean-response.sh"
  action :add
end

nagios_nrpecheck "Amp-Extended-500-Rate" do
  command "#{node[:amp][:logging][:script_path]}/apiparse.py -i #{node[:amp][:logging][:log_path]}/$(ls -ltr #{node[:amp][:logging][:log_path]} | grep -v error | tail -1 | awk '{print $9}') -t requests -c 4"
  action :add
end

nagios_nrpecheck "Amp-Extended-Logins" do
  command "#{node[:amp][:logging][:script_path]}/apiparse.py -i #{node[:amp][:logging][:log_path]}/$(ls -ltr #{node[:amp][:logging][:log_path]} | grep -v error | tail -1 | awk '{print $9}') -t logins -c 5"
  action :add
end

nagios_nrpecheck "Amp-PGBouncer" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  parameters '-C pgbouncer'
  action :add
end

# For the couchbase bucket memory usage checks

nagios_nrpecheck "Check_CBM_catalog" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b catalog --memory-used -W 3774873600 -C 3984588800'
  action :add
end

nagios_nrpecheck "Check_CBM_default" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b default --memory-used -W 56623104000 -C 59768832000'
  action :add
end

nagios_nrpecheck "Check_CBM_l3stream" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b l3stream --memory-used -W 3865470566 -C 4080218931'
  action :add
end

nagios_nrpecheck "Check_CBM_live-episodes" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b live-episodes --memory-used -W 3865470566 -C 4080218931'
  action :add
end

nagios_nrpecheck "Check_CBM_radio-sessions" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b radio-sessions --memory-used -W 18874368000 -C 19922944000'
  action :add
end

nagios_nrpecheck "Check_CBM_search" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b search --memory-used -W 7549747200 -C 7969177600'
  action :add
end

nagios_nrpecheck "Check_CBM_sessions" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b sessions --memory-used -W 11596411699 -C 12240656793'
  action :add
end
