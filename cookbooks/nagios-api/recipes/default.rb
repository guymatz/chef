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

include_recipe "users::deployer"

directory "/data/www" do
  owner "ihr-deployer"
  group "apache"
end

pips = %w{ diesel requests }
pips.each do |p| 
  python_pip p do
    action :upgrade
  end
end

%w{ nagios_cli }.each do |p|
  package p
end

template "/etc/rc.d/init.d/nagios-api" do
  mode "0755"
  source "nagios-api.sh.erb"
  variables({
    :deploy_key => "/etc/chef/nagiosapi_identity"
  })
end

service "nagios-api" do
	  action [:enable, :start]
end
