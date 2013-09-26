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

unless tagged?("partners-deployed")
  application "partners" do
    path "/data/apps/partners/"
    owner node[:partners][:deployer]
    group node[:partners][:group]
    repository node[:partners][:repo]
    revision node[:partners][:rev]
    migrate false
    shallow_clone false

    django do
      interpreter "python27"
      requirements "requirements.txt"
    end

    gunicorn do
      app_module :django
      worker_class "gevent"
      port 8080
      autostart true
      workers 9
      virtualenv "#{node[:partners][:deploy_path]}/shared/venv"
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
