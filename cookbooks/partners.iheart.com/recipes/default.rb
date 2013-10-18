#
# Cookbook Name:: partners
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:partners][:packages].each do |p|
  package p
end

db_creds = Chef::EncryptedDataBagItem.load("partners", "db-creds")

unless tagged?("partners-deployed")
  application "partners" do
    path node[:partners][:deploy_path] 
    owner node[:partners][:deployer]
    group node[:partners][:group]
    repository node[:partners][:repo]
    revision node[:partners][:rev]
    migrate false
    shallow_clone false
    before_migrate do
      bash "chown" do
        code "chown -R #{node[:partners][:deployer]}. #{node[:partners][:deploy_path]}"
      end
    end
    before_restart do
      template "#{node[:partners][:deploy_path]}/current/partners_portal/settings_local.py" do
        source "settings_local.py.erb"
        owner node[:partners][:deployer]
        group node[:partners][:group]
        variables({ :db_creds => db_creds,
                    :partners_env => node.chef_environment
                  })
      end
    end

    django do
      packages ["gevent"]
      interpreter "/usr/bin/python2.7"
      requirements "requirements.txt"
    end

    gunicorn do
      app_module :django
      version "17.5"
      worker_class "gevent"
      port 8080
      autostart true
      workers 9
    end
  end

    directory "/var/log/partners" do
      owner 'root'
      group 'ihr-deployer'
      mode "775"
      action :create
      not_if { FileTest.directory?("/var/log/partners") }
    end

    logrotate_app "partners" do
      cookbook "logrotate"
      path "/var/log/partners/*.log"
      options ["missingok", "copytruncate", "compress", "notifempty"]
      frequency "daily"
      enable true
      create "0644 nobody root"
      rotate 2
    end


    tag("partners-deployed")
  end
