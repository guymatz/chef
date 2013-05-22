#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ users::elasticsearch users::deployer elasticsearch::elasticsearch }.each do |cb|
  include_recipe cb
end

directory node[:elasticsearch][:ihrsearch_path] do
  recursive true
end

pkg = "configs.tgz"

execute "Untar-ihr-search-configs" do
  command "tar zxf #{pkg} -C #{node[:elasticsearch][:ihrsearch_path]}"
  cwd Chef::Config[:file_cache_path]
  creates "#{node[:elasticsearch][:ihrsearch_path]}/configs"
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
  source "#{node[:elasticsearch][:url]}/es-configs/#{pkg}"
  checksum "8f70c5c7fc45"
  notifies :run, resources(:execute => "Untar-ihr-search-configs")
end
