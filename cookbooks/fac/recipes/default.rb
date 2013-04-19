#
# Cookbook Name:: fac
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
include_recipe "java"

Chef::Log.info("Bandaiding FAC with some /etc/hosts entries")
ruby_block "fac-etc-hosts" do
  block do
    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match("/mongodb-fac1b01/", "10.90.47.182\tmongodb-fac1b01")
    file.insert_line_if_no_match("/mongodb-fac1b02/", "10.90.47.183\tmongodb-fac1b02")
    file.insert_line_if_no_match("/mongodb-fac1b03/", "10.90.47.184\tmongodb-fac1b03")
    file.insert_line_if_no_match("/mongodb-fac1b04/", "10.90.47.185\tmongodb-fac1b04")
    file.write_file
  end
  not_if { node.normal.attribute?('whipped') }
  notifies :restart, "service[network]"
end
