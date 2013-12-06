#
# Cookbook Name:: ingestion-ng
# Recipe:: freetds
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ freetds freetds-devel }.each do |p|
  package p
end

template "/etc/freetds.conf"

template "/etc/odbc.ini"
