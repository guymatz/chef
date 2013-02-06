#
# Cookbook Name:: oncall
# Recipe:: default
#
# Copyright 2012, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

application "oncall" do
  name "oncall"
  path "/data/www/oncall"
  owner "nobody"
  group "nogroup"
  repository node[:oncall][:repo]
  revision node[:oncall][:rev]
  migrate false
  environment_name "production"
  action :deploy

  # django do
  #   requirements "requirements.txt"
  #   debug true
  #   settings_template "settings.py.erb"
  # end

  gunicorn do

    Chef::Log.info("Starting up Gunicorn on port 8081 for OnCall")
    port 8081
  end
end
