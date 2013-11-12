#
# Cookbook Name:: radioedit
# Recipe:: prod-nfs-mount
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Sets up an nfs mount for binary asset storage 
# As per JIRA Ticket: OPS-5784
#
# #######################################################

mount "#{node[:radioedit][:prod][:nfs_locdir]}" do
  device "#{node[:radioedit][:prod][:nfs_locdir]}:#{node[:radioedit][:prod][:nfs_remdir]}"
  fstype "nfs"
  options "rw"
  action [:mount, :enable]
end