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
gpg_keys = Chef::EncryptedDataBagItem.load("partners", "gpg-keys")
gpg_keys = gpg_keys.to_hash

unless tagged?("partners-deployed")
  application "partners" do
    path node[:partners][:deploy_path] 
    owner node[:partners][:deployer]
    group node[:partners][:group]
    repository node[:partners][:repo]
    revision node[:partners][:rev]
    migrate false
    shallow_clone false
#    before_migrate do
#      bash "chown" do
#        code "chown -R #{node[:partners][:deployer]}. #{node[:partners][:deploy_path]}"
#      end
#    end
    before_restart do
      template "#{node[:partners][:deploy_path]}/current/partners_portal/settings_local.py" do
        source "settings_local.py.erb"
        owner node[:partners][:deployer]
        group node[:partners][:group]
        variables({ :db_creds => db_creds,
                    :partners_env => node.chef_environment
                  })
      end
      template "/etc/odbc.ini" do
        source "settings_local.py.erb"
        owner node[:partners][:deployer]
        group node[:partners][:group]
        variables({ :partners_env => node.chef_environment
                  })
      end
      gpg_keys.each do |key, value|
        file "#{node[:partners][:deploy_path]}/current/#{key}" do
          content value
          owner node[:partners][:deployer]
          group node[:partners][:group]
        end
      end
      bash "import keys" do
        cwd "#{node[:partners][:deploy_path]}/current/#{key}"
        code <<-EOH
        mkdir keyring
        gpg --homedir keyring/ --import gooddata-sso.pub
        gpg --homedir keyring/ --allow-secret-key-import --import cc.gpg
        chmod 0700 -R keyring/
        EOH
        user node[:partners][:deployer]
        group node[:partners][:group]
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
