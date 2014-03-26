#
# Cookbook Name:: couchbase
# Recipe:: v2-1-install.rb
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs Couchbase 2.1
#
# #######################################

# need to uninstall membase-server or it conflicts with couchbase-server 
# (normally this is easy via package management, however, chef adds a certain barrier of easy use)
package "membase-server" do
  action :remove
end

directory "/data/apps/couchbase/data" do
  owner "couchbase"
  group "couchbase"
  recursive true
  action :create
end

# that rpm is the default rpm in our repo
# yum_package "couchbase-server*1.8.1*.x86_64" do 
yum_package "couchbase-server = 1.8.1" do 
  action :install     
end