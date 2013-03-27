#
# Cookbook Name:: encoder
# Recipe:: default
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::epel"

node[:pkgs].each do |pkg|
  package pkg do
    action :install
    not_if { node.normal.attribute?("encoder_deployed") }
  end
end

ruby_block "deployed_flag" do
  block do
    node.set['encoder_deployed'] = true
    node.save
  end
end
