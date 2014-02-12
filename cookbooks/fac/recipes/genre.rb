#
# Cookbook Name:: fac
# Recipe:: genre
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

app = "genre"
download_url = "#{node[:fac][:url]}/FAC-#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}"

directory "#{script_dir}" do
  recursive true
end

remote_file "#{script_dir}/#{node[:fac][app][:version]}.jar" do
  Chef::Log.info("Downloading fac-#{app} from #{download_url}")
  source "#{download_url}"
  mode "0755"
end

remote_file "#{script_dir}/env.properties-#{node[:fac][app][:version]}"
  

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
              :jarfile => "#{script_dir}/#{node[:fac][app][:version]}.jar"
            })
end

template "#{script_dir}/fac-incremental-runner.sh" do
  source "fac-incremental-runner.sh.erb"
  owner "nobody"
  group "nobody"
  mode "0755"
  variables({
              :script_dir => script_dir,
              :radiobuild_dir => "#{node[:fac][:script_path]}/radiobuild",
              :radiobuild2_dir => "#{node[:fac][:script_path]}/radiobuild2"
            })
end

cron_d "fac-genre" do
 minute "*/5"
 command ""
 else
   command "/usr/bin/cronwrap #{node[:hostname]} fac-music \"#{script_dir}/fac-incremental-runner.sh\""
 end
 user "root"
end
