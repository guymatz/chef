#
# Cookbook Name:: radioedit
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.warn('THIS RECIPE IS SCHEDULED TO BE DELETED. PLEASE ALERT OPS/ADMINS IF THIS RECIPE (radioedit::image) IS STILL REQUIRED. -GP 02/18/13');

directory "#{node[:radioedit][:image][:path]}" do
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
end

node[:radioedit][:image][:packages].each do |p|
  package p
end

application "radioedit-image" do
  repository node[:radioedit][:image][:repo]
  branch node[:radioedit][:image][:branch]
  path node[:radioedit][:image][:path]
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
    Chef::Log.info("Starting up Gunicorn on port #{node[:radioedit][:image][:port]} for Radioedit-Image")
    port node[:radioedit][:image][:port]
    worker_processes 10
    listen node[:radioedit][:image][:listen]
    command ""
    pid "/var/run/radioedit-image.pid"
  end

end
