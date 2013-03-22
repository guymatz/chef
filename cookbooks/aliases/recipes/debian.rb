#
# Cookbook Name:: aliases
# Recipe:: debian
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/debian.sh" do
  source "debian.sh"
  owner "root"
  group "root"
  mode "0755"
end
