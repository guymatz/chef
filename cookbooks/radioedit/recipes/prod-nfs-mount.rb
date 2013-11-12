#
# Cookbook Name:: radioedit
# Recipe:: prod-nfs-mount
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs all prerequisits and sets up an nfs mount for binary asset storage 
# As per JIRA Ticket: OPS-5784
#
# #######################################################

 
%w{ nfs-utils nfs-utils-lib }.each do |p|
  package p do
    action :install
  end
end

directory "#{node[:radioedit][:production][:nfs_locdir]}" do
  owner "ihr-deployer"
  group "ihr-deployer"
  action :create
end

mount "#{node[:radioedit][:production][:nfs_locdir]}" do
  device "#{node[:radioedit][:production][:nfs_server]}:#{node[:radioedit][:production][:nfs_remdir]}"
  fstype "nfs"
  options "rw"
  action [:mount, :enable]
end