#
# Cookbook Name:: operations
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['operations']['packages'].each do |p|
  package p
end

cookbook_file "/usr/local/sbin/colorize-strace" do
  source "colorize-strace"
  mode "0755"
  owner "root"
  group "root"
  action :create_if_missing
end
