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

%w{ python27 python27-libs python27-devel python27-test python27-tools libevent-devel unixODBC-devel }.each do |p|
  package p
end

directory "/data/apps/partners/shared/venv" do
  recursive true
  owner node[:partners][:deployer]
  group node[:partners][:group]
  action :create
end

python_virtualenv "/data/apps/partners/shared/venv" do
  interpreter "/usr/bin/python27"
  owner node[:partners][:deployer]
  group node[:partners][:group]
  action :create   
end

    unless tagged?("partners-deployed")

    application "partners" do
      path "/data/apps/partners/"
      owner node[:partners][:deployer]
      group node[:partners][:group]
      repository node[:partners][:repo]
      revision node[:partners][:rev]
      before_restart do
        bash "setup venv" do
          code <<-EOH
          chown -R #{node[:partners][:deployer]}. #{node[:partners][:deploy_path]}
          . /data/apps/partners/shared/venv/bin/activate && \
          pip install -r "/data/apps/partners/shared/cached-copy/requirements.txt"
          pip install gevent
          EOH
        end
      end

      gunicorn do
        app_module "partners:app"
        host "0.0.0.0"
        port 8080
        workers 9
        worker_class "gevent"
        virtualenv "/data/apps/partners/shared/venv"
        autostart true
        accesslog "/var/log/partners/partners-gunicorn-access.log"
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

bash "setup venv" do
      code <<-EOH
      chown -R #{node[:partners][:user]}. #{node[:partners][:deploy_path]}
      EOH
end
