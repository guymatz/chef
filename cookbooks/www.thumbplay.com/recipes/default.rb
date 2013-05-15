#
# Cookbook Name:: www.thumbplay.com
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::deployer"
include_recipe "apache2"

directory "/data/www/www.thumbplay.com" do
  owner node[:apache][:user]
  group "ihr-deployer"
  mode 0770
  recursive true
end

git node[:thumbplay][:path] do
  repository node[:thumbplay][:repo]
  revision node[:thumbplay][:revision]
  action :sync
end

web_app "www.thumbplay.com" do
  server_name "test.thumbplay.com"
  server_aliases "*.thumbplay.com, thumbplaymusic.com, *.thumbplaymusic.com"
  docroot node[:thumbplay][:path]
end
