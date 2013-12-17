#
# Cookbook Name:: disaster_recovery
# Recipe:: nfs.rb
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::attivio"

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
