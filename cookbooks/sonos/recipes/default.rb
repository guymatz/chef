#
# Cookbook Name:: sonos
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node[:sonos][:packages].each do |pkg|
  package pkg
end

%w{ mysql::client }.each do |cb|
  include_recipe cb
end

application "sonos" do
  path node[:sonos][:deploy_path]
  repository node[:sonos][:repo]
  revision node[:sonos][:rev]
  action :deploy

  django do
    interpreter "python27"
    requirements "requirements.txt"
    debug true
    settings_template "settings.py.erb"
  end

  gunicorn do
    app_module :django
    Chef::Log.info("Starting up gunicorn on port 8080 for SONOS")
    port 8080
  end
end

