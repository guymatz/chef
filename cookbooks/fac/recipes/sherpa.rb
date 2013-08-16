#
# Cookbook Name:: sherpa
# Recipe:: talk
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
app = "sherpa"
jar_file = "FAC-#{app}-#{node[:fac][app][:version]}.jar"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/#{jar_file}"
script_dir = "#{node[:fac][:script_path]}/#{app}"
start_script = "fac-#{app}-runner.sh"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/#{jar_file}" do
  Chef::Log.info("Downloading #{download_url}")
  source "#{download_url}"
  mode "0755"
  action :create_if_missing
end

link "#{script_dir}/fac-#{app}.jar" do
  to "#{script_dir}/#{jar_file}" 
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
    :jarfile => "#{script_dir}/#{jar_file}"
  })
end

cron_d "fac-sherpa" do
 minute "12"
 hour "12"
 command "/usr/bin/cronwrap use1b-jobserver101a fac-sherpa \"#{script_dir}/#{start_script}\""
 user "root"
end
