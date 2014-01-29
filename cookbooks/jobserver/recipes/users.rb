#
# Cookbook Name:: jobserver
# Recipe:: users
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Searches data bag "users" for groups attribute "sysadmin".
# Places returned users in Unix group "sysadmin" with GID 2300.
include_recipe "users::root"
  users_manage "converter" do
  group_id 2300
  action [ :remove, :create ]
end
#
