#
# Cookbook Name:: tomcat_latest
# Recipe:: default
#
# Copyright 2013, Chendil Kumar Manoharan
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
include_recipe "java"
include_recipe "tomcat7::nagios"

group node[:tomcat7][:group] do
  gid 91
  action [:create]
end

user node[:tomcat7][:user] do
  comment "Tomcat Service User"
  shell "/sbin/nologin"
  uid 91
  gid 91
  action [:create]
end

remote_file "#{Chef::Config[:file_cache_path]}/tomcat7.tar.gz" do
  source "#{node[:tomcat7][:url]}/v#{node[:tomcat7][:version]}/bin/apache-tomcat-#{node[:tomcat7][:version]}.tar.gz"
  action :create_if_missing
end

directory "#{node[:tomcat7][:install_path]}" do
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  recursive true
end

directory "/var/run/tomcat/" do
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  recursive true
end

execute "Untar Apache Tomcat 7 binary file" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  command "tar zxvf tomcat7.tar.gz -C #{node[:tomcat7][:install_path]} --strip-components=1"
  action :run
  not_if "test -d #{node[:tomcat7][:install_path]}/conf"
end

template "#{node[:tomcat7][:install_path]}/conf/server.xml" do
  source "server7.xml.erb"
  owner "root"
  mode "0644"
  not_if "test -f #{node[:tomcat7][:install_path]}/conf/server.xml"
end

bash "tomcat perms" do
  code "chown -R #{node[:tomcat7][:user]}.#{node[:tomcat7][:group]} #{node[:tomcat7][:install_path]};"\
       "chmod 775 #{node[:tomcat7][:install_path]}/logs"
end

template "/etc/init.d/tomcat" do
  source "tomcat7.erb"
  owner "root"
  mode "0755"
end

node.set[:tomcat7][:webapp_dir] = "#{node[:tomcat7][:install_path]}/webapps"
node.save
