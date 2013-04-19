
#
# Cookbook Name:: vast
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tomcat7"
include_recipe "users::vast"
node.save

service "tomcat" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end

remote_file "#{node[:tomcat7][:webapp_dir]}/vast.war" do
  Chef::Log.info("Installing vast.war from #{node[:vast][:url]}")
  source node[:vast][:url]
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  action :create_if_missing
  only_if "test -d #{node[:tomcat7][:webapp_dir]}"
  notifies :restart, "service[tomcat]", :immediately
end
