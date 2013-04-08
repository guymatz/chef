#
# Cookbook Name:: nagios-api
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
#"state_dir": "/var/lib/nagios3",
#"log_dir": "/var/log/nagios3",
#"home": "/usr/lib/nagios3",

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "nagiosapi")
file "/etc/chef/nagiosapi_identity" do
  content app_secrets['private_key']
  owner "nobody"
  group "nobody"
  mode "0600"
end

template "/etc/chef/ssh_wrapper_nobody.sh" do
  user node[:nagiosapi][:user]
  group node[:nagiosapi][:group]
  mode "0700"
  source "ssh_wrapper.erb"
  variables({
              :deploy_key => "/etc/chef/nagiosapi_identity"
            })
end

git "#{node[:nagiosapi][:path]}" do
  path node[:nagiosapi][:path]
  owner node[:nagiosapi][:user]
  group node[:nagiosapi][:group]
  ssh_wrapper "/etc/chef/nobody_ssh_wrapper"
  repository node[:nagiosapi][:repo]
  revision node[:nagiosapi][:rev]
  action :sync
end

# supervisor_service "nagios-api" do
#   command "/usr/bin/nagios-api -p #{node[:nagiosapi][:server][:port]} -c /var/lib/nagios3/rw/nagios.cmd -s /var/cache/nagios3/status.dat -l /var/log/nagios3/nagios.log"
#   autostart true
#   autorestart true
#   stdout_logfile "/var/log/nagios-api.log"
#   stderr_logfile "/var/log/nagios-api.err.log"
# end
