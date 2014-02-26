#
# Cookbook Name:: iscale
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template '/etc/init.d/iscale' do
  action :delete
end

template "#{node[:iscale][:install_path]}/settings.json" do
  action :delete
end 

directory "#{node[:iscale][:install_path]}" do
  action :delete
end

log "Will not remove /etc/sysconfig/varnish" do
  level :warn
end

log "Will not remove /etc/varnish/default.vcl" do
  level :warn
end
