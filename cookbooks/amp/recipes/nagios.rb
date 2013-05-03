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
  notifies :restart, resources(:service => "nagios-nrpe-server")
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
  notifies :restart, resources(:service => "nagios-nrpe-server")
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
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

