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

directory "#{node[:fbgraph][:deploy_path]}" do
  recursive true
end

%w{ amqp-fbgraph-1.0.0.jar env.properties log4j.xml }.each do |fbfile|
  remote_file "#{node[:fbgraph][:deploy_path]}/#{fbfile}" do
    Chef::Log.info("Downloading #{fbfile} from #{node[:fbgraph][:url]}/live/#{fbfile}-#{node[:fbgraph][:version]}")
    source "#{node[:fbgraph][:url]}/#{fbfile}-#{node[:fbgraph][:version]}"
    mode "0755"
    action :create
  end
end

# init directories
%w{ /var/run/fbgraph }.each do |dir|
  directory dir do
    recursive true
    mode "0755"
  end
end

directory "/var/log/fbgraph-consumer" do
  recursive true
  mode "0755"
end

template "/etc/init.d/fbgraph" do
  source "fbgraph.init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
              :app => 'fbgraph',
              :jarfile => "#{node[:fbgraph][:deploy_path]}/fbgraph.jar",
              :basedir => node[:fbgraph][:deploy_path]
            })
  action :create
end

# nagios_nrpecheck "Facebook-Process-FBgraph" do
#   warning_condition "1:1"
#   critical_condition "1:1"
#   parameters "-C  /var/run/fbgraph/fbgraph.pid"
#   action :add
# end


# nagios_nrpecheck "Facebook-Process-Mongos" do
#   command "#{node['nagios']['plugin_dir']}/check_procs"
#     warning_condition "1:1"
#     critical_condition "1:1"
#     parameters "-C mongos"
#     action :add
# end

#cron_d "restart_fbgraph" do
#  minute 0
#  hour 17
#  command "/etc/init.d/fbgraph restart"
#end
