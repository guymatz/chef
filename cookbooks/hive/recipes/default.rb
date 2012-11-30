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
  action :create_if_missing
end

bash "extract-package: java-mysql-connector" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
tar xf mysql-connector-java-#{node[:hive][:version]}.tar.gz
mysql-connector-java-5.1.22/mysql-connector-java-5.1.22-bin.jar /usr/lib/hive/lib/
EOH
  not_if "test -f /usr/lib/hive/lib/mysql-connector-java-5.1.22-bin.jar"
end
