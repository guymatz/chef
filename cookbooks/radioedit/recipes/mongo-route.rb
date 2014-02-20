#
# Cookbook Name:: radioedit
# Recipe::mongo-route
# Description::Configures a static route for mongo connections
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

#route add -net 10.10.155.0/24 gw 10.5.52.1
route "10.10.155.0/24" do
  gateway "10.5.52.1"
  action :add
end