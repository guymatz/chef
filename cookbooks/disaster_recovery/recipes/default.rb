#
# Cookbook Name:: disaster_recovery
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::deployer"

directory "#{node[:sto][:base_path]}/dr_backups" do
  mode "0775"
  action :create
end

nfs_export "#{node[:sto][:base_path]}/dr_backups" do
  network "10.5.32.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/dr_backups" do
  network "10.5.40.0/23"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/dr_backups" do
  network "10.5.42.128/25"
  writeable true
  sync true
  options ["no_root_squash"]
end

nfs_export "#{node[:sto][:base_path]}/dr_backups" do
  network "10.5.43.0/25"
  writeable true
  sync true
  options ["no_root_squash"]
end
