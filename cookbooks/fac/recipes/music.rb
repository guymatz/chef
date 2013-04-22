#
# Cookbook Name:: fac
# Recipe:: music
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# this is to setup keys for shipping files
include_recipe "attivio::users"

app = "music"
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

template "#{script_dir}/fac-incremental-runner.sh" do
  source "fac-incremental-runner.sh.erb"
  owner "nobody"
  group "nobody"
  mode "0755"
  variables({
              :script_dir => script_dir,
              :radiobuild_dir => "#{node[:fac][:script_path]}/radiobuild"
            })
end

cron_d "fac-music" do
  minute "2"
  hour "2"
  day "2" # tuesday
  command "cronwrap iad-jobserver101 fac-music \"#{script_dir}/fac-incremental-runner.sh\" 2>&1 > /var/log/fac-#{app}"
  user "root"
end
