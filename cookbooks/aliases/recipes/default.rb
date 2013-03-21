#
# Cookbook Name:: aliases
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/common_aliases.sh" do
  source "common_aliases.sh"
  owner "root"
  group "root"
  mode "0755"
end
