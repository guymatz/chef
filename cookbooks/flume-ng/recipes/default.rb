#
# Cookbook Name:: flume-ng
# Recipe:: default
# Author:: pkatsev
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ java users::flume }.each do |dep|
  include_recipe dep
end

# ==================== package ====================

directory node[:flume_ng][:base_path] do
  recursive true
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

execute "untar-flume-ng" do
  cwd Chef::Config[:file_cache_path]
  command "tar zxf #{node[:flume_ng][:package]}.tar.gz -C #{node[:flume_ng][:base_path]}"
  user node[:flume_ng][:user]
  group node[:flume_ng][:group]
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:flume_ng][:package]}.tar.gz" do
  source "#{node[:flume_ng][:base_url]}/#{node[:flume_ng][:package]}.tar.gz"
  checksum "#{node[:flume_ng][:checksum]}"
  notifies :run, "execute[untar-flume-ng]", :immediately
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

link node[:flume_ng][:home] do
  to "#{node[:flume_ng][:base_path]}/#{node[:flume_ng][:package]}"
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

# =================== directories ===================

%w{ log_dir run_dir }.each do |dir_attr_key|
  directory node[:flume_ng][dir_attr_key] do
    owner node[:flume_ng][:user]
    group node[:flume_ng][:group]
  end
end

# ==================== templates ====================

conf_dir = "#{node[:flume_ng][:home]}/#{node[:flume_ng][:conf_dir]}"

# select agent configuration template to use depending on the node role
template_src = if node.run_list.include?("role[amp]")
  "amp"
elsif node.run_list.include?("role[amp-logger]")
  "amp-logger"
else
  "amp"
  # "namenode"
end

template "#{conf_dir}/#{node[:flume_ng][:conf_file]}" do
  source "#{template_src}.conf.erb"
  notifies :restart, "service[flume-ng-agent]"
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

template "#{conf_dir}/flume-env.sh" do
  mode 0755
  notifies :restart, "service[flume-ng-agent]"
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

template "#{conf_dir}/log4j.properties" do
  notifies :restart, "service[flume-ng-agent]"
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

template "/etc/profile.d/flume-ng.sh" do
  mode 0755
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

template "/etc/init.d/flume-ng-agent" do
  mode 0755
  owner node[:flume_ng][:user]
  group node[:flume_ng][:group]
end

# ==================== services ====================

service "flume-ng-agent" do
  supports :start => true, :stop =>true, :restart => true
  action [:enable, :start]
end
