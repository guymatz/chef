#
# Cookbook Name:: basejump
# Recipe:: default
#
# Copyright 2012, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#


include_recipe "mysql::client"

node['basejump']['packages'].each do |pkg|
  package pkg
end

application "basejump" do
  name "basejump"
  path "/data/www/basejump"
  owner "nobody"
  group "nogroup"
  repository node[:basejump][:repo]
  revision node[:basejump][:rev]
  enable_submodules true
  migrate true
  environment_name "production"
  action :deploy

  app_secrets = Chef::EncryptedDataBagItem.load("secrets", "#{node[:basejump][:app_name]}")

  db_user = node[:basejump][:db_user]
  db_name = node[:basejump][:db_name]

  Chef::Log.info("Setting up DB for Basejump")
  Chef::Log.info("USER: " + db_user)
  Chef::Log.info("DB_NAME: " + db_name)
  Chef::Log.info("PASS: " + app_secrets['pass'])

  django do
    requirements "requirements.txt"
    debug true
    settings_template "settings.py.erb"
    database_master_role "db_master"
    database do
      database db_name
      username db_user
      password app_secrets['pass']
      engine "mysql"
    end
  end

  gunicorn do
    app_module :django
    Chef::Log.info("Starting up Gunicorn on port 8080 for Basejump")
    port 8080
  end
end

include_recipe "basejump::kickstarter"
