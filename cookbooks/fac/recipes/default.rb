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

hosts = Hash.new
hosts["mongodb-fac1b01"] = "10.90.47.182"
hosts["mongodb-fac1b02"] = "10.90.47.183"
hosts["mongodb-fac1b03"] = "10.90.47.184"
hosts["mongodb-fac1b04"] = "10.90.47.185"
hosts["qa2-mongodb-fac0a01.ccrd.clearchannel.com"] = "10.9.176.31"
hosts["qa2-mongodb-fac0a02.ccrd.clearchannel.com"] = "10.9.176.32"
hosts.each do |host,ip|
  hostsfile_entry ip do
    hostname host
  end
end
