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

pips = %w{ requests }
pips.each do |p| 
  python_pip p do
    action :upgrade
  end
end

template "/usr/bin/nagios-cli" do
  mode "0755"
  source "nagios-cli.py.erb"
  variables({
    :api_host => node[:nagiosapi][:server][:name],
    :api_port => node[:nagiosapi][:server][:port]
  })
end
