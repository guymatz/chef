#
# Cookbook Name:: iscale
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

application "iscale" do
  path "/data/apps/iscale"
  owner "root"
  group "root"
  repository 'git@github.com:iheartradio/iscale.git'
  revision 'master'
end