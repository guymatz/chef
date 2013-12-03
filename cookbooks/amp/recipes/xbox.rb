#
# Cookbook Name:: amp
# Recipe:: xbox
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

service "tomcat" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end

remote_file "#{node[:tomcat7][:webapp_dir]}/xbox.war" do
  source "#{node[:amp][:url]}/#{node[:chef_environment]}/xbox.war"
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  mode "0755"
  action :create_if_missing
  notifies :restart, "service[tomcat]"
end
