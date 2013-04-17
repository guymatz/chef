#
# Cookbook Name::       cassandra
# Description::         Base configuration for cassandra
# Recipe::              default
# Author::              Benjamin Black (<b@b3k.us>)
#
# Copyright 2010, Benjamin Black
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

# == Recipes

include_recipe "java" 
include_recipe "thrift"

# == Packages

# == Users

#daemon_user(:cassandra) do
#  create_group  false
#end

group "cassandra" do
   gid 502
end

user "cassandra" do
    uid 502
    gid 502
    shell "/bin/bash"
    action :create
end

# == Directories

#standard_dirs('cassandra') do
#  directories   [:conf_dir, :log_dir, :lib_dir, :pid_dir, :data_dirs, :commitlog_dir, :saved_caches_dir]
#  group         'root'
#end



directory "#{node[:cassandra][:log_dir]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:cassandra][:lib_dir]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:cassandra][:pid_dir]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:cassandra][:data_dirs]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:cassandra][:commitlog_dir]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:cassandra][:saved_caches_dir]}" do
  owner "cassandra"
  group "cassandra"
  mode 0755
  recursive true
  action :create
end

mount "#{node['cassandra']['data_root_mount']}" do
  device "#{node['cassandra']['data_device']}"
  fstype "ext4"
  options "rw,noatime,data=writeback,nobh"
  action [:mount, :enable]
end

