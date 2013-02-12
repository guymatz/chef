#
# Cookbook Name:: yum
# Recipe:: default
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

node[:yum][:packages].each { |pkg| package pkg }

package node[:yum][:fastestmirror]

package 'yum-priorities' do
  package_name value_for_platform(
    'fedora' => { 'default' => 'yum-plugin-priorities' },
    'default' => 'yum-priorities'
  )
  action :install
end

# We don't want to enable automatic updates on production machines.
package 'yum-updatesd' do
  action node[:yum][:updatesd].to_sym
end

# Override and use local repos if you have a local mirror.
server = search(:node, 'recipes:yum\:\:mirror') || []
if server.length > 0
  osver = node[:platform_version].to_i
  arch = node[:kernel][:machine]

  server.each do |srv|
    hostsfile_entry 'yumrepo' do
      ip srv[:ipaddress]
      aliases [ srv[:hostname], srv[:fqdn], 'mirror' ]
      comment "added by recipe yumrepo::default"
    end

    if srv[:yum][:mirror][:sync_centos] == true
      Chef::Log.debug "Overriding yum::centos"
      node.set[:yum][:release][:baseurl] = 'http://mirror/centos/$releasever/os/$basearch/'
      node.set[:yum][:updates][:baseurl] = 'http://mirror/centos/$releasever/updates/$basearch/'
      node.set[:yum][:contrib][:baseurl] = 'http://mirror/centos/$releasever/contrib/$basearch/'
      node.set[:yum][:addons][:baseurl]  = 'http://mirror/centos/$releasever/addons/$basearch/'
      node.set[:yum][:extra][:baseurl]   = 'http://mirror/centos/$releasever/extras/$basearch/'
      node.set[:yum][:plus][:baseurl]    = 'http://mirror/centos/$releasever/centosplus/$basearch/'
    end
  end

  # TODO - this is a little too hard coded for your own good no?
  node.set[:yum][:custom][:baseurl] = "http://yumrepo/custom/el#{osver}/$basearch"
  node.set[:yum][:custom][:enabled] = true

else
  Chef::Log.info("No local yum mirror server found.")
end

# This space is managed by RPM. We don't want to use it to make it clear we
# ship our own repos.
#directory '/etc/yum.repos.d' do
#  action :delete
#  recursive true
#end

directory node[:yum][:repodir] do
  action :create
  owner 'root'
  group 'root'
  mode '755'
end

template node[:yum][:conf] do
  source 'yum.conf.erb'
  mode '444'
  owner 'root'
  group 'root'
end

# Enable the yum repos
node[:yum][:repos].uniq.each { |r| yum_repository r }

# vi:filetype=ruby:tabstop=2:expandtab
