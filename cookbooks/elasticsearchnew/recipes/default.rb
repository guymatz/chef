#
# Cookbook Name:: elasticsearchnew
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ users::elasticsearch elasticsearchnew::users users::deployer elasticsearchnew::elasticsearch elasticsearchnew::ulimits elasticsearchnew::plugins }.each do |cb|
  include_recipe cb
end

%w{ configs data input logs }.each do |der|
  directory "#{node[:elasticsearchnew][:ihrsearch_path]}/#{der}" do
    owner node[:elasticsearchnew][:user]
    owner node[:elasticsearchnew][:group]
    recursive true
  end
end

pkg = "configs.tgz"

execute "chown-ihr-search-configs" do
  command "chown -R #{node[:elasticsearchnew][:user]}.#{node[:elasticsearchnew][:group]} #{node[:elasticsearchnew][:ihrsearch_path]}"
  action :nothing
end

execute "Untar-ihr-search-configs" do
  command "tar zxf #{pkg} -C #{node[:elasticsearchnew][:ihrsearch_path]}/configs"
  cwd Chef::Config[:file_cache_path]
  creates "#{node[:elasticsearchnew][:ihrsearch_path]}/configs/artists"
  action :nothing
  notifies :run, resources(:execute => "chown-ihr-search-configs")
end

remote_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
  source "#{node[:elasticsearchnew][:url]}/es-configs/#{pkg}"
  checksum "8f70c5c7fc45"
  notifies :run, resources(:execute => "Untar-ihr-search-configs")
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

cluster_members = search(:node, "cluster_name:#{node[:elasticsearchnew][:cluster_name]}")

cluster_ips = Array.new
cluster_members.each do |s|
  cluster_ips << s[:network][:interfaces][:eth1][:addresses].keys.first
end

template "#{node[:elasticsearchnew][:ihrsearch_path]}/configs/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  variables({
              :cluster_ips => cluster_ips
             })
  notifies :restart, "service[elasticsearch]"
end

template "#{node[:elasticsearchnew][:ihrsearch_path]}/configs/logging.yml" do
  source "logging.yml.erb"
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
end
