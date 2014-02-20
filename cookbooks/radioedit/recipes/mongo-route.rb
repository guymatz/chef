#
# Cookbook Name:: radioedit
# Recipe::mongo-route
# Description::Configures a static route for mongo connections
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

route "#{node[:radioedit][:mongo_route][:network]}" do
  gateway "#{node[:radioedit][:mongo_route][:gateway]}"
  action :add
end