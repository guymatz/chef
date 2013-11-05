#
# Cookbook Name:: encoder
# Recipe:: ftp server
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

# Required for "custom" hash function in template
class Chef::Recipe::Proftpd
  include Helper
end

# Get our encrypted data
users = Chef::EncryptedDataBagItem.load("music_upload", "upload_users-dev").to_hash

template "#{node[:proftpd][:user_file]}" do
  source "ftpd.passwd.erb"
  mode 0644
  owner node[:proftpd][:user]
  group node[:proftpd][:group]
  variables(
    :users => users
  )
  helpers(Helper)
end
