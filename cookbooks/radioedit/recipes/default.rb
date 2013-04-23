#
# Cookbook Name:: radioedit
# Recipe::default (core)
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

remote_file "/etc/yum.repos.d/zeromq.repo" do
  source "http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo"
end

node[:radioedit][:core][:packages].each do |p|
  package p
end

node[:radioedit][:core][:pips].each do |p|
  python_pip p
end
