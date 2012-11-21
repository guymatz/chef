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
