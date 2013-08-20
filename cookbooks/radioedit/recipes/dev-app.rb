#
# Cookbook Name:: radioedit
# Recipe:: dev-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a dev version of an app server
#

yum_package "memcached" do
  arch "x86_64"
  action [ :install, :upgrade ]
end