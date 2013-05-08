#
# Cookbook Name:: monitoring
# Recipe:: dell
#
# Copyright 2013, iHeartRadio
# Written by Jake Plimack <jake.plimack@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# All the rpms are in our iheart/dell repo
# Do not install repos, ever.  we don't trust them that much

case node['platform_family']
when "rhel"
  package "srvadmin-all"
end

link "/etc/init.d/dell-omsa" do
  to "/opt/dell/srvadmin/sbin/srvadmin-services.sh"
end

service "dell-omsa" do
  supports :start => true
  action :start
end
