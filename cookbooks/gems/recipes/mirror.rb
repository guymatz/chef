#
# Cookbook Name:: gems
# Recipe:: mirror
#
# Copyright 2009, Opscode, Inc.
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
# Set up a mirror for RubyForge

include_recipe "rsync"

package "ruby"
package "rubygems"

gem_package "rubygems-mirror" do
  action :install
  ignore_failure true
end

template "/root/.gem/.mirrorrc" do
  source "mirrorrc.erb"
end

directory "#{node[:gem_server][:rf_directory]}" do
  owner "root"
  group "root"
  mode "0755"
end

directory "#{node[:gem_server][:rf_directory]}/gems" do
  owner "root"
  group "root"
  mode "0755"
end

cron_d "mirror-rubyforge" do
  command "gem mirror > /dev/null 2>&1 && gem generate_index -d #{node[:gem_server][:rf_directory]}" 
  hour "4"
  minute "0"
end

template "#{node[:apache][:dir]}/sites-available/rubyforge_mirror.conf" do
  source "gem_server.conf.erb"
  variables(
    :virtual_host_name => node[:gem_server][:rf_virtual_host_name],
    :virtual_host_alias => node[:gem_server][:rf_virtual_host_alias],
    :gem_directory => node[:gem_server][:rf_directory]
  )
  owner "root"
  mode 0755
end

apache_site "rubyforge_mirror.conf"
