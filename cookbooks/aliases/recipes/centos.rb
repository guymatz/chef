#
# Cookbook Name:: aliases
# Recipe:: centos
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/profile.d/centos.sh" do
  source "centos.sh"
  owner "root"
  group "root"
  mode "0755"
end
