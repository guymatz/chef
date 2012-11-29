#
# Cookbook Name:: collins
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:collins][:packages].each do |p|
  package p
end

directory "/root/src/play-#{node[:collins][:play][:version]}" do
  owner "root"
  group "root"
  recursive true
end

remote_file "/root/src/play-#{node[:collins][:play][:version]}/play-#{node[:collins][:play][:version]}.zip" do
  Chef::Log.info("Downloading from #{node[:collins][:play][:url]}")
  source node[:collins][:play][:url]
  action :create_if_missing
end

bash "extract package" do
  cwd "/root/src/play-#{node[:collins][:play][:version]}"
  code "unzip -oq play-#{node[:collins][:play][:version]}.zip"
end

git "/root/src/collins" do
  repository node[:collins][:repository]
  revision "HEAD"
  reference "master"
  action :sync
  user "root"
  group "root"
end

