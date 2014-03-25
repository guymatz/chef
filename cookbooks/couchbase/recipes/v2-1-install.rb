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

# that rpm is the default rpm in our repo
package "couchbase-server-1.8.1-937.x86_64" do 
  action :install
end