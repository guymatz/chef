#
# Cookbook Name:: host-sflow
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node[:hsflow][:packages].each do |pkg|
  package pkg
end

template "/etc/hsflowd.conf" do
  source "hsflowd.conf"
  owner "root"
  group "root"
  mode "0755"
  notifies :restart, "service[hsflowd]"
end

service "hsflowd" do
  supports :start => true, :stop => true, :restart => true
  action [:enable, :start]
end
