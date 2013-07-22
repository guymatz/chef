#
# Cookbook Name:: shared-storage
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nfs::server"

directory node[:sto][:base_path] do
  recursive true
end

node.set[:openssh][:server][:Subsystem] = "sftp internal-sftp"
node.save

%w{ files.ihrdev.com::nfs }.each do |share|
  include_recipe share
end

cron_d "remove_old_logs" do
  command "find /data/logs -mtime +4 -delete > /dev/null 2>&1"
  hour 1
  minute 0
end
