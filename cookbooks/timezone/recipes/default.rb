#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2012, iHeartRadio
#
# All rights reserved - Do Not Redistribute, or use.
#

file "/etc/localtime" do
  action :delete
  not_if "test -L /etc/localtime && ! $(readlink /etc/localtime) =~ #{node['timezone']['zonefile']}"
end

link "/etc/localtime" do
  to "#{node['timezone']['zonefile']}"
end
