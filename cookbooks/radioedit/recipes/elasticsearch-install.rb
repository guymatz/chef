#
# Cookbook Name:: radioedit
# Recipe::elasticsearch-install
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

package "java-1.7.0-openjdk-devel" 
package "elasticsearch"

service "elasticsearch" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [:enable, :start]
end 

