#
# Cookbook Name:: ops.ihrdev.com
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"

directory "/data/www/files.ihrdev.com" do
  owner node[:apache][:user]
  group "ihr-deployer"
  mode 0770
  recursive true
end

web_app "files.ihrdev.com" do
  server_name "files.ihrdev.com"
  server_aliases "files.ihr"
  docroot node[:files_ihrdev_com][:path]
end
