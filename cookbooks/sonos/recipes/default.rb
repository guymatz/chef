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

  unless tagged?("sonos-deployed")
  Chef::Log.info('entered deploy block')
	application "sonos" do
	  path node[:sonos][:deploy_path]
	  repository node[:sonos][:repo]
	  revision node[:sonos][:rev]
	  action :deploy
	
	  all_secrets = Chef::EncryptedDataBagItem.load("secrets", "sonos")
	  app_secrets = all_secrets[node.chef_environment]
	  db_user = app_secrets['db_user']
	  db_name = "sonos_#{node.chef_environment}".gsub('-', '_')
	  django do
	    interpreter "python27"
	    requirements "requirements.txt"
	    debug true
	    settings_template "settings.py.erb"
	    database_master_role "sonos-database"
	    database do
	      database db_name
	      username db_user
	      password app_secrets['db_pass']
	      engine "mysql"
	    end
	  end
	
	  gunicorn do
	    app_module :django
	    Chef::Log.info("Starting up gunicorn on port 8080 for SONOS")
	    port 8080
	  end
	end

	tag("sonos-deployed")
	end
