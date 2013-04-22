#
# Cookbook Name:: membase
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# we set the common uid of 497, but move the homedir to /data/membase.
# Local storage data is kept in /data/membase/data
include_recipe "users::membase"

node[:membase][:packages].each do |pkg|
  package pkg
end

directory node[:membase][:data_path] do
  owner node[:membase][:user]
  group node[:membase][:group]
  mode "0755"
end

service "membase-server" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end
