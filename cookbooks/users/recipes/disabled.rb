#
# Cookbook Name:: users
# Recipe:: disabled
#

# Searches data bag "users" for groups attribute "disabled" and deletes them.

users_manage "disabled" do
  action :remove
end

