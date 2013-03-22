#
# Cookbook Name:: aliases
# Recipe:: admin
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/admin.sh" do
  source "admin.sh"
  owner "root"
  group "root"
  mode "0755"
end
