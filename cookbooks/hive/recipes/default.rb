#
# Cookbook Name:: hive
# Recipe:: default
#
# Copyright 2012, Clearchannel.com (iHeartRadio)
# Written by Jake Plimack <jake.plimack@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

node[:hive][:packages].each do |p|
  package p
end

remote_file "#{Chef::Config[:file_cache_path]}/mysql-connector-java-#{node[:hive][:version]}.tar.gz" do
  url = node[:hive][:url_pre] + node[:hive][:version] + ".tar.gz"
  Chef::Log.info("Downloading mysql-connector-java from " + url)
  source url
  action :create_if_missing
end

bash "extract-package: java-mysql-connector" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
tar xf mysql-connector-java-#{node[:hive][:version]}.tar.gz
cp mysql-connector-java-5.1.22/mysql-connector-java-5.1.22-bin.jar /usr/lib/hive/lib/
EOH
  not_if "test -f /usr/lib/hive/lib/mysql-connector-java-5.1.22-bin.jar"
end


app_secrets = Chef::EncryptedDataBagItem.load("secrets", node[:hive][:app_name])

if node[:roles].include?('db_master')
  db_server = 'localhost'
else
  results = search(:node, "recipes:hive\\:\\:mysql")
  db_server = results[0][:fqdn]
end

template "/etc/hive/conf/hive-site.xml" do
  source "hive-site.xml.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
              :db_host => db_server,
              :db_user => node[:hive][:db_user],
              :db_name => node[:hive][:db_name],
              :db_pass => app_secrets['pass']
            })
end
