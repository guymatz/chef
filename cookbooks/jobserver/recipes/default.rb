#
# Cookbook Name:: jobserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node.chef_environment == 'prod'
  include_recipe "jobserver::ha"
end

