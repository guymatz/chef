#
# Cookbook Name:: aliases
# Recipe:: git
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/git.sh" do
  source "git.sh"
  owner "root"
  group "root"
  mode "0755"
end
