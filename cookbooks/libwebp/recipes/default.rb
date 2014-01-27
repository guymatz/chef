#
# Cookbook Name:: libwebp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

 yum_package libwebp do
  action [ :install, :upgrade ]
  arch 'x86_64'
  version "0.4.0"
end