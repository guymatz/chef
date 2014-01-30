#
# Cookbook Name:: disaster_recovery
# Recipe:: nfs.rb
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::attivio"
include_recipe "users::elasticsearch"
include_recipe "postgresql::users"
include_recipe "users::mongo"

directory "#{node[:disaster_recovery][:base_path]}/dr_backups" do
  mode "0775"
  action :create
  recursive true
end

directory "#{node[:disaster_recovery][:base_path]}/dr_backups/attivio" do
  mode "0775"
  owner "attivio"
  group "attivio"
  action :create
end

es_nodes = search(:node, "role:elasticsearchnew AND chef_environment:#{node.chef_environment}")

es_nodes.each do |es_node|
  directory "#{node[:disaster_recovery][:base_path]}/dr_backups/elasticsearch/#{es_node[:hostname]}" do
    action :create
    recursive true
    mode "0755"
    owner "elasticsearch"
    group "elasticsearch"
  end
end

%w{mongo_fac_bak mongo_util_bak mongo_usr_bak}.each do |dir|
  directory "#{node[:disaster_recovery][:base_path]}/dr_backups/#{dir}" do
    mode 00775
    owner "mongod"
    group "mongod"
    action :create
    recursive true
  end
end

%w{auth_bak ing_bak}.each do |dir|
  directory "#{node[:disaster_recovery][:base_path]}/dr_backups/#{dir}" do
    mode 00775
    owner "postgres"
    group "postgres"
    action :create
    recursive true
  end
end


nfs_export "#{node[:disaster_recovery][:base_path]}/dr_backups" do
  network "10.5.32.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:disaster_recovery][:base_path]}/dr_backups" do
  network "10.5.40.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:disaster_recovery][:base_path]}/dr_backups" do
  network "10.5.42.128/25"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:disaster_recovery][:base_path]}/dr_backups" do
  network "10.5.43.0/25"
  writeable true
  sync true
  options ["no_root_squash"]
end
