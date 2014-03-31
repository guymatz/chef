#
# Cookbook Name:: fac
# Recipe:: music2
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# this is to setup keys for shipping files
include_recipe "attivio::users"

app = "music2"
download_url = "#{node[:fac][:files_url]}/#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
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

template "#{node[:fac][:script_path]}/FACConfig.properties" do
  source "FACConfig.properties.erb"
  owner "root"
  group "root"
  action :create_if_missing
  variables({
		  # INCOMPLETE
            })
end


#cron_d "fac-music2" do
# minute "2"
# hour "0"
# # weekday "2" # tuesday
# if tagged?("no-fac-music")
#   command "#/usr/bin/cronwrap #{node[:hostname]} fac-music \"#{script_dir}/fac-incremental-runner.sh\""
# else
#   command "/usr/bin/cronwrap #{node[:hostname]} fac-music \"#{script_dir}/fac-incremental-runner.sh\""
# end
# user "root"
#end
