#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "elasticsearch::users"

%w{ users::elasticsearch users::deployer elasticsearch::elasticsearch elasticsearch::ulimits elasticsearch::plugins }.each do |cb|
  include_recipe cb
end

%w{ configs data input logs }.each do |der|
  directory "#{node[:elasticsearch][:ihrsearch_path]}/#{der}" do
    owner node[:elasticsearch][:user]
    owner node[:elasticsearch][:group]
    recursive true
  end
end

pkg = "configs.tgz"

execute "chown-ihr-search-configs" do
  command "chown -R #{node[:elasticsearch][:user]}.#{node[:elasticsearch][:group]} #{node[:elasticsearch][:ihrsearch_path]}"
  action :nothing
end

execute "Untar-ihr-search-configs" do
  command "tar zxf #{pkg} -C #{node[:elasticsearch][:ihrsearch_path]}/configs"
  cwd Chef::Config[:file_cache_path]
  creates "#{node[:elasticsearch][:ihrsearch_path]}/configs/artists"
  action :nothing
  notifies :run, resources(:execute => "chown-ihr-search-configs")
end

remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
  source "#{node[:elasticsearch][:url]}/es-configs/#{pkg}"
  checksum "8f70c5c7fc45"
  notifies :run, resources(:execute => "Untar-ihr-search-configs")
end

searchers = search(:node, "role:elasticsearch")
cluster_ips = Array.new
searchers.each do |s|
  cluster_ips << s[:ipaddress]
end

template "#{node[:elasticsearch][:ihrsearch_path]}/configs/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
  variables({
              :cluster_ips => cluster_ips
             })
  notifies :restart, "service[elasticsearch]"
end

template "#{node[:elasticsearch][:ihrsearch_path]}/configs/logging.yml" do
  source "logging.yml.erb"
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
end

template "/etc/init.d/elasticsearch" do
  source "elasticsearch.init.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :restart, "service[elasticsearch]"
end

service "elasticsearch" do
  supports :start => true, :stop =>true, :restart => true
  action [:enable, :start]
end
