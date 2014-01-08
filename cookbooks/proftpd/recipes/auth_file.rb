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
db = node[:proftpd][:data_bag]
di = node[:proftpd][:data_item_users]
users = Chef::EncryptedDataBagItem.load(db, di).to_hash

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
