# Cookbook Name:: disaster_recovery
# Recipe:: default.rb
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "apache2::mod_autoindex"

web_app "dr.ihr" do
  server_name "dr.ihr"
  server_aliases ["disaster-recovery.ihr"]
  docroot node[:disaster_recovery][:base_path]
  directory_options ["Indexes", "FollowSymLinks"]
end
