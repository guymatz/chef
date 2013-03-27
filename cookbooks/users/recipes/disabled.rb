#
# Cookbook Name:: users
# Recipe:: disabled
#
# Copyright 2013, Jake Plimack

# Searches data bag "users" for groups attribute "disabled" and deletes them.

users_manage "disabled" do
  action :remove
end

