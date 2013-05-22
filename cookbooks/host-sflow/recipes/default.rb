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

collectors = node[:hsflow][:collectors]

template "/etc/hsflowd.conf" do
  source "hsflowd.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  variables({
              :collectors => collectors
            })
  notifies :restart, "service[hsflowd]"
end

service "hsflowd" do
  supports :start => true, :stop => true, :restart => true
  action [:enable, :start]
end
