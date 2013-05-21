#
# Cookbook Name:: apache2
# Recipe:: mod_sflow
#
# Copyright 2008-2012, Opscode, Inc.
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

include_recipe "host-sflow"

case node['platform_family']
when "debian"
  package "pcre-dev"
when "rhel", "fedora", "arch"
  package "pcre-devel"
end

remote_file "#{Chef::Config[:file_cache_path]}/mod-sflow-1.0.3.tar.gz" do
  source "http://mod-sflow.googlecode.com/files/mod-sflow-1.0.3.tar.gz"
  action :create_if_missing
end

bash "extract mod_sflow" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
tar zxvf mod-sflow-1.0.3.tar.gz
cd mod-sflow-1.0.3
apxs -c mod_sflow.c sflow_api.c
cp .libs/mod_sflow.so #{node[:apache][:lib_dir]}/modules/mod_sflow.so
EOH
  not_if "test -f #{node[:apache][:lib_dir]}/modules/mod_sflow.so"
end

# file "#{node[:apache][:dir]}/mods-available/mod_sflow.load" do
#   owner node[:apache][:user]
#   group node[:apache][:group]
#   content "LoadModule mod_sflow #{node[:apache][:lib_dir]}/modules/mod_sflow.so"
# end

apache_module "sflow"
