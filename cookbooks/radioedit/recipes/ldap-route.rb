#
# Cookbook Name:: radioedit
# Recipe::ldap-route
# Description::Configures a static route for ldap connections
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

route "#{node[:radioedit][:ldap_route][:network]}" do
  gateway "#{node[:radioedit][:ldap_route][:gateway]}"
  action :add
end