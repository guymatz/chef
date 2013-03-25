#
# Cookbook Name:: aliases
# Recipe:: chef
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/chef.sh" do
  source "chef.sh"
  owner "root"
  group "root"
  mode "0755"
end
