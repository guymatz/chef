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

node.default['couchbase']['server']['version'] = "2.1.1";

include_recipe 'couchbase::server'