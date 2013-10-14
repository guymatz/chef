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
  command "#{node['nagios']['plugin_dir']}/check_procs -C pgbouncer"
end
