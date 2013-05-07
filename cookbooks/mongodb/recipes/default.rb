#
# Cookbook Name:: mongodb
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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
