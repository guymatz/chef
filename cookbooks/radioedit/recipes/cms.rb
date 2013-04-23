#
# Cookbook Name:: radioedit
# Recipe:: cms
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# default recipe is also called "radioedit-core"
include_recipe "radioedit::default"

remote_file "/etc/yum.repos.d/zeromq.repo" do
  source "http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo"
end

directory "#{node[:radioedit][:cms][:path]}" do
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
end

node[:radioedit][:cms][:packages].each do |p|
  package p
end

application "radioedit-cms" do
  repository node[:radioedit][:cms][:repo]
  revision node[:radioedit][:image][:branch]
  path node[:radioedit][:cms][:path]
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
  migrate false
  action :deploy

  django do
    interpreter "python27"
    requirements "requirements.txt"
    debug true
    settings_template "settings.py.erb"
  end

  gunicorn do
    app_module :django
    Chef::Log.info("Starting up Gunicorn on port #{node[:radioedit][:cms][:port]} for Radioedit-CMS")
    port node[:radioedit][:cms][:port]
    workers 10
    host node[:radioedit][:cms][:host]
    command "radioedit.wsgi"
    pidfile "/var/run/radioedit-cms.pid"
  end

end
