#
# Cookbook Name:: partners
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#%w{ users::partners }.each do |cb|
#  include_recipe cb
#end

node[:partners][:packages].each do |p|
  package p
end

db_creds = Chef::EncryptedDataBagItem.load("partners", "db-creds")

unless tagged?("partners-deployed")
  application "partners" do
    path "/data/apps/partners/"
    owner node[:partners][:deployer]
    group node[:partners][:group]
    repository node[:partners][:repo]
    revision node[:partners][:rev]
    migrate false
    shallow_clone false

    before_restart do
      template "/data/apps/partners/current/settings_local.py" do
        source "settings_local.py.erb"
        variables({ :db_creds => db_creds })
      end
    end

    django do
      interpreter "/usr/bin/python2.7"
      requirements "requirements.txt"
    end

    gunicorn do
      app_module :django
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
