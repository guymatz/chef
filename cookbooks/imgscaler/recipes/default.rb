#
# Cookbook Name:: imgscaler
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "jdK"

cookbook_file "#{Chef::Config[:file_cache_path]}/imgscaler.tar.gz" do
  source "imgscaler.tar.gz"
  action :create
end


