#
# Cookbook Name:: amp
# Recipe:: logger
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#


node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
%w{ users::amp java tomcat7 }.each do |r|
  include_recipe r
end


service "tomcat" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end

remote_file "#{node[:tomcat7][:webapp_dir]}/logger.war" do
  Chef::Log.info("Installing logger.war from #{node[:amp][:logger][:url]}")
  source node[:amp][:logger][:url]
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  action :create_if_missing
  only_if "test -d #{node[:tomcat7][:webapp_dir]}"
  notifies :restart, "service[tomcat]", :immediately
end

directory "/var/run/tomcat" do
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  recursive true
end

template "#{node[:tomcat7][:install_path]}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  mode "0755"
  variables({
              :tomcat_dir => node[:tomcat7][:install_path]
            })
end
