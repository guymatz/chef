#
# Cookbook Name:: sherpa
# Recipe:: talk
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
app = "sherpa"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}"
start_script = "fac-#{app}-runner.sh"

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

template "#{script_dir}/#{start_script}" do
  source "#{start_script}.erb"
  mode "0755"
  owner "root"
  group "root"
  variables({
    :envfile => "#{script_dir}/env.properties",
    :jarfile => "#{script_dir}/#{node['fac']['sherpa']['jarfile']}-#{node['fac']['sherpa']['version']}.jar"
  })
end

nagios_nrpecheck "Fac-Process-Sherpa" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  #  This checks for the sherpa jarfile without the version number
  parameters "-C java -a #{node['fac']['sherpa']['jarfile']}"
  action :add
end

cron_d "fac-sherpa" do
 minute "12"
 hour "12"
 command "/usr/bin/cronwrap use1b-jobserver101a fac-sherpa \"#{script_dir}/#{start_script}\""
 user "root"
end
