#
# Cookbook Name:: ops.ihrdev.com
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::deployer"
include_recipe "apache2"

directory "/data/www/ops.ihrdev.com" do
  owner node[:apache][:user]
  group "ihr-deployer"
  mode 0770
  recursive true
end

git node[:ops][:path] do
  repository node[:ops][:repo]
  revision node[:ops][:revision]
  action :sync
end

web_app "ops.ihrdev.com" do
  server_name "ops.ihrdev.com"
  server_aliases "ops.ihr"
  docroot node[:ops][:path]
end
