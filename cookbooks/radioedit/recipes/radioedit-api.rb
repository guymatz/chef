#
# Cookbook Name:: radioedit-api
# Recipe:: radioedit-api
#
#
#
# All rights reserved - Do Not Redistribute
# Installs/deploys the radioedit app server
#
#
# authors:  jderagon
# 
#  Sun Feb 23 13:50:23 EST 2014
# 
#  Stub to setup the api service
## dev testing
untag("radioedit.app_api")

radioedit_unicorn "app_api" do
    action :init
    #not_if { node.tags.include?(radioedit.app_api) }
end


# 
# static files served through a redirect in nginx conf file.
# [this is only on the core/api server]
# 

template "#{node[:radioedit][:legacy_root]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end


service "nginx" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end


