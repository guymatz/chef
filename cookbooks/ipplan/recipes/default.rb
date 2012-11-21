#
# Cookbook Name:: ipplan
# Recipe:: default
#
# Copyright 2012, Clearchannel Communications
# Written by Jake Plimack <jakeplimack@clearchannel.com>
#
# All rights reserved - Do Not Redistribute
#

version = node[:ipplan][:version]

remote_file "#{Chef::Config[:file_cache_path]}/ipplan-#{version}.tar.gz" do
  puts "Downloading from #{node[:ipplan][:package_url]}"
  source node[:ipplan][:package_url]
#  checksum node[:ipplan][:checksum]
  action :create_if_missing
end

directory node[:ipplan][:install_path] do
  owner node[:apache][:user]
  group node[:apache][:group]
  mode 0755
end

bash "extract-package" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxvf ipplan-#{version}.tar.gz
    mv ipplan/* #{node[:ipplan][:install_path]}
  EOH
  not_if "test #{node[:ipplan][:install_path]}/ipplan/index.php"
end

results = search(:node, "roles:mysql-server-ec2")
db_server = results[0]

mysql_connection_info = {
  :host => db_server['fqdn'],
  :username => "root",
  :password => db_server['mysql']['server_root_password']
}

mysql_database "ipplan" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "ipplan" do
  connection mysql_connection_info
  database_name "ipplan"
  host '%'
  privileges [:select, :update, :insert, :delete]
  action :create
end

template "#{node[:ipplan][:install_path]}/config.php" do
  source "config.php.erb"
  mode "0755"
  variables(
            :db_server => db_server
            )
end
