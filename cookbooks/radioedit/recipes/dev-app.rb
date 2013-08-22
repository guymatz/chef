#
# Cookbook Name:: radioedit
# Recipe:: dev-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a dev version of an app server
#

include_recipe "radioedit::default"
include_recipe "yum::epel"

# make a directory to stash builds in 
directory "/root/build" do
  owner "root"
  group "root"
  action :create
end

# need to install the memcached package as a dep of libmemcached 
yum_package "memcached" do
  arch "x86_64"
  action [ :install, :upgrade ]
end

# install libmemcached from source 
# @TODO: change to rpm install 
remote_file "/root/build/libmemcached-0.51.tar.gz" do
  source "https://launchpad.net/libmemcached/1.0/0.51/+download/libmemcached-0.51.tar.gz"
  notifies :run, "bash[install_libmemcached]", :immediately
end

bash "install_libmemcached" do
  user "root"
  cwd "/root/build"
  code <<-EOH
    tar -zxf libmemcached-0.51.tar.gz
    (cd libmemcached-0.51/ && ./configure && make && make install)
  EOH
  action :nothing
end

sudo "tlong" do
  group "tlong"
  commands ["ALL"]
  runas "root"
  nopasswd true
end


