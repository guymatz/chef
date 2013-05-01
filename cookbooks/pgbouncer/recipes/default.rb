#
# Cookbook Name:: pgbouncer
# Recipe:: default
# Author:: Christoph Krybus <ckrybus@googlemail.com>
# Author:: Bryan W. Berry (<bryan.berry@gmail.com>)
#
# Copyright 2011, Christoph Krybus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node[:pgbouncer][:packages].each do |pkg|
  package pkg
end

%w{ logrotate postgresql }.each do |prereq|
  include_recipe prereq
end

pgb_user = node['pgbouncer']['user']


case node['platform']
when "redhat","centos","scientific","fedora","suse"
  package "cronie"
  version = node['postgresql']['version'].split('.').join('')
end

remote_file "#{Chef::Config[:file_cache_path]}/pgbouncer-1-5-4.tar.gz" do
  source "http://yum.ihr/files/pgbouncer-1.5.4.tar.gz"
  owner "root"
  group "root"
  action :create_if_missing
end

bash "compile pgbouncer" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
cd #{Chef::Config[:file_cache_path]}
tar zxvf pgbouncer-1-5-4.tar.gz
cd pgbouncer-1.5.4
./configure
make && make install
EOH
  not_if "test -f /usr/local/bin/pgbouncer"
end

service "pgbouncer" do
  action :nothing
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
end

# EL rpms don't create this directory automatically
directory "/etc/pgbouncer" do
  owner pgb_user
  group pgb_user
  mode  "774"
end

template node[:pgbouncer][:initfile] do
  source "pgbouncer.ini.erb"
  owner "root"
  group pgb_user
  mode "664"
  notifies :reload, resources(:service => "pgbouncer")
  not_if "test -f #{node[:pgbouncer][:initfile]}"
end

template node[:pgbouncer][:additional_config_file] do
  source "pgbouncer.sysconfig.erb"
  owner pgb_user
  group pgb_user
  mode "664"
  notifies :reload, resources(:service => "pgbouncer")
end

template "/etc/init.d/pgbouncer" do
  source "pgbouncer_init.erb"
  owner "root"
  group "root"
  mode "775"
  notifies :restart, resources(:service => "pgbouncer")
end

service "pgbouncer" do
  action [:enable]
end

logrotate_app "pgbouncer" do
  cookbook "logrotate"
  path "/var/log/pgbouncer.log"
  frequency "daily"
  create "644 root root"
  rotate 30
end

# add sudoers
sudo pgb_user do
  template "sudo.erb"
  variables(
            {
              "name" => pgb_user,
              "service" => "pgbouncer"
            }
            )
end
