#
# Cookbook Name:: proftpd::sshkeys_files
# Recipe:: ftp server
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

db = node[:proftpd][:data_bag]
di = node[:proftpd][:data_item_keys]
users = Chef::DataBagItem.load(db, di).to_hash

users.each do |username,ssh_keys|
  keys=''
  # Chef 11 has some weird extra keys we don't want
  next if ["id","data_bag","chef_type"].include?(username)
  # If keys are not an array, we treat them differnt
  if ssh_keys.is_a?(String)
    keys = ssh_keys
  elsif ssh_keys.is_a?(Array)
    ssh_keys.sort!.each do |key|
      keys = keys + key + "\n"
    end
  else
    log("Can't make key file for #{username} with: #{ssh_keys}")
  end
  # Now write out the authorized keys file for the user
  file "#{node[:proftpd][:key_dir]}/#{username}" do
    content	keys
    owner	node[:proftpd][:ftp_user]
    group	node[:proftpd][:ftp_group]
    mode    	0700
  end
end
