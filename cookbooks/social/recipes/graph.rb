#
# Cookbook Name:: facebook
# Recipe:: graph
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
include_recipe "java"
include_recipe "tomcat7"

directory "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}" do
  owner node[:social_graph][:user]
  group node[:social_graph][:group]
  recursive true
end

%w{ social_graph-jar-with-dependencies.jar env.properties.erb log4j.xml }.each do |social_file|
  remote_file "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}/#{social_file}" do
    Chef::Log.info("Downloading #{social_file} from #{node[:social_graph][:url]}/#{node[:social_graph][:version]}/#{social_file}")
    source "#{node[:social_graph][:url]}/#{node[:social_graph][:version]}/#{social_file}"
    mode "0755"
    owner node[:social_graph][:user]
    group node[:social_graph][:group]
    action :create_if_missing
  end
end

template "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}/env.properties" do
      source "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}/env.properties.erb"
      local true
end

# init directories
%w{ /var/run/social_graph }.each do |dir|
  directory dir do
    recursive true
    owner node[:social_graph][:user]
    group node[:social_graph][:group]
    mode "0755"
  end
end

directory "/var/log/social_graph" do
  recursive true
  owner node[:social_graph][:user]
  group node[:social_graph][:group]
  mode "0755"
end

template "/etc/init.d/social_graph" do
  source "social_graph.init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
              :app => 'social_graph',
              :jarfile => "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}/social_graph-jar-with-dependencies.jar",
              :basedir => "#{node[:social_graph][:deploy_path]}/#{node[:social_graph][:version]}"
            })
end

nagios_nrpecheck "Social-Process-Socialgraph" do
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C  /var/run/social_graph/social_graph.pid"
  action :add
end


nagios_nrpecheck "Social-Process-Mongos" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
    warning_condition "1:1"
    critical_condition "1:1"
    parameters "-C mongos"
    action :add
end

#cron_d "restart_social_graph" do
#  minute 0
#  hour 17
#  command "/etc/init.d/social_graph restart"
#end
