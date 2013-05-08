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
  to "#{node[:dell][:omsa][:path]}/sbin/srvadmin-services.sh"
end

service "dell-omsa" do
  supports :start => true
  action :start
end

omreport = "#{node[:dell][:omsa][:path]}/bin/omreport"

nagios_nrpecheck "Dell-Performance-Profile" do
  command "#{omreport} chassis biossetup | grep 'System Profile' | grep 'Performance$'"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
