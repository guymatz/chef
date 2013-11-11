#
# Cookbook Name:: proftpd::sshkeys_files
# Recipe:: ftp server
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#


users = Chef::DataBagItem.load("music_upload", "upload_user-keys").to_hash

users.each do |username,ssh_keys|
  keys=''
  next if username == "id"
  # If keys are not an array, we treat them differnt
  if ssh_keys.is_a?(String)
    keys = ssh_keys
  elsif ssh_keys.is_a?(Array)
    ssh_keys.sort!.each do |key|
      keys = keys + key + "\r\n"
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
