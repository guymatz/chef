#
# Cookbook Name:: fac
# Recipe:: talk
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
app = "talk"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/fac-#{app}.jar" do
  Chef::Log.info("Downloading fac-#{app} from #{download_url}")
  source "#{download_url}"
  mode "0755"
  action :create_if_missing
end

# init directories
%w{ /var/run/fac }.each do |dir|
  directory dir do
    recursive true
    mode "0755"
  end
end

directory "/var/log/fac-#{app}" do
  recursive true
  mode "0755"
end

template "/etc/init.d/fac-#{app}" do
  source "fac.init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
              :fac_app => app,
              :jarfile => "#{script_dir}/fac-#{app}.jar"
            })
end

if node.has_key? 'heartbeat'
  Chef::Log.info("Creating Heartbeat Config: fac-talk")
  node.set[:heartbeat][:ha_resources]["fac-talk"] = "fac-talk"
  node.save
end

nagios_nrpecheck "Fac-Process-Talk" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C java -a '-Xmx4G -jar /data/jobs/fac/talk/fac-talk.jar initialOverlap=200'"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
