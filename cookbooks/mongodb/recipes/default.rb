#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "logrotate"

node[:mongodb][:packages].each do |mongo_pkg|
  yum_package mongo_pkg do
    arch nil
  end
end

directory "#{node[:mongodb][:logdir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:mongodb][:data_dir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

logrotate_app "mongo-logs" do 
  cookbook "logrotate"
  path "#{node[:mongodb][:logdir]}/*.log"
  enable true
  frequency "daily"
  size 104857600
  create "644 mongod mongod"
  rotate 10
end
