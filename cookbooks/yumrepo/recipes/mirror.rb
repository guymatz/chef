#
# Cookbook Name:: yumrepo
# Recipe:: mirror
#
# Copyright 2011, Stefano Harding
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

include_recipe 'rsync'
include_recipe 'apache2'
include_recipe 'apache2::mod_rewrite'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

package node[:yum][:mirror][:package]

dirs = [
  node[:yum][:mirror][:bindir],
  node[:yum][:mirror][:yumdir]
]

if ! node[:yum][:mirror][:centos_version].empty?
  node[:yum][:mirror][:centos_version].each do |x|
    dirs.push("#{node[:yum][:mirror][:yumdir]}/centos/#{x}")
  end
end

dirs.each do |dir|
  directory dir do
    action :create
    recursive true
    owner 'root'
    group 'root'
    mode '755'
  end
end

template "#{node[:yum][:mirror][:bindir]}/yum-repo-sync.rb" do
  source 'yum-repo-sync.rb.erb'
  owner 'root'
  group 'root'
  mode '755'
end

cron_d 'Sync Yum repos' do
  command "#{node[:yum][:mirror][:bindir]}/yum-repo-sync.rb > /dev/null 2>&1"
  hour node[:yum][:mirror][:cron_hour]
  minute node[:yum][:mirror][:cron_minute]
end

template 'yumrepo.conf' do
  path "#{node[:apache][:dir]}/sites-available/yumrepo.conf"
  source 'yumrepo.conf.erb'
  owner 'root'
  group 'root'
  mode '444'
end

apache_site 'yumrepo.conf'

apache_site '000-default' do
  enable false
end

#Setup symlinks once the data is there
if ! node[:yum][:mirror][:centos_links].empty?
  node[:yum][:mirror][:centos_links].each do |key, value|
    if File.directory?("#{node[:yum][:mirror][:yumdir]}/centos/#{value}")
      link "#{node[:yum][:mirror][:yumdir]}/centos/#{value}" do
        to "#{node[:yum][:mirror][:yumdir]}/centos/#{key}"
      end
    end
  end
end
# vi:filetype=ruby:tabstop=2:expandtab
