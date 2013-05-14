#
# Cookbook Name:: ops.ihrdev.com
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "nfs"

nfs_server = search(:node, "recipe:files.ihrdev.com\\:\\:nfs AND chef_environment:#{node.chef_environment}")[0]

directory "/data/www/files.ihrdev.com" do
  action :create
end

mount "/data/www/files.ihrdev.com" do
  device "#{nfs_server[:hostname]}-v600.ihr:/data/exports/files.ihrdev.com"
  fstype "nfs"
  options "noatime,nocto"
  action [:mount, :enable]
end

web_app "files.ihrdev.com" do
  server_name "files.ihrdev.com"
  server_aliases "files.ihr"
  docroot node[:files_ihrdev_com][:path]
  directory_options ["Indexes", " FollowSymLinks"]
end
