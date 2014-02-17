#
# Cookbook Name:: fac
# Recipe:: genre
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

app = "genre"
download_url = "#{node[:fac][:files_url]}/#{app}/#{node[:fac][app][:version]}/FAC-#{app}-#{node[:fac][app][:version]}.jar"
script_dir = "#{node[:fac][:script_path]}/#{app}/#{node[:fac][app][:version]}"

directory "#{script_dir}" do
  recursive true
end

dwh_creds = Chef::EncryptedDataBagItem.load("secrets", "dwh_radiomodel_creds")

remote_file "#{script_dir}/FAC-#{app}-#{node[:fac][app][:version]}.jar" do
  Chef::Log.info("Downloading fac-#{app} from #{download_url}")
  source "#{download_url}"
  mode "0755"
end

remote_file "#{script_dir}/env.properties.erb" do
  source "#{node[:fac][:files_url]}/#{app}/#{node[:fac][app][:version]}/env.properties.erb"
end

template "#{script_dir}/env.properties" do
  source "#{script_dir}/env.properties.erb"
  local true
  variables({
                :dwh_radiomodel_creds => dwh_creds
        })
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

cron_d "fac-genre" do
 minute "*/5"
 command "java -jar #{script_dir}/FAC-#{app}-#{node[:fac][app][:version]}.jar jobPropertyFile=#{script_dir}/env.properties"
 user "root"
end
