#
# Cookbook Name:: news
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ users::news }.each do |cb|
  include_recipe cb
end

%w{ python27 python27-libs python27-devel python27-test python27-tools }.each do |p|
  package p
end

directory "/data/apps/newsletter/shared/venv" do
  recursive true
  owner node[:news][:deployer]
  group node[:news][:group]
  action :create
end

python_virtualenv "/data/apps/newsletter/shared/venv" do
  interpreter "/usr/bin/python27"
  owner node[:news][:deployer]
  group node[:news][:group]
  action :create   
end

begin
    unless tagged?("newsletter-deployed")

    application "newsletter" do
      path "/data/apps/newsletter/"
      owner node[:news][:deployer]
      group node[:news][:group]
      repository node[:news][:repo]
      revision node[:news][:rev]
      before_restart do
        bash "setup venv" do
          code <<-EOH
          chown -R #{node[:news][:deployer]}. #{node[:news][:news_path]}
          . /data/apps/newsletter/shared/venv/bin/activate && \
          pip install -r "/data/apps/newsletter/shared/cached-copy/requirements.txt"
          EOH
        end
        template "/data/apps/newsletter/current/dfp_settings.py" do
          source "dfp_settings.py.erb"
          owner node[:news][:user]
          group node[:news][:group]
          mode 0644
          variables({
                  :news => node[:news]
          })
        end
      end

      gunicorn do
        app_module "dfp:app"
        host "0.0.0.0"
        port 8080
        workers 9
        workers_class "gevent"
        virtualenv "/data/apps/newsletter/shared/venv"
        autostart true
        accesslog "/var/log/newsletter/newsletter-gunicorn-access.log"
      end
    end

    directory "/var/log/newsletters" do
        owner 'root'
        group 'root'
        action :create
        not_if { FileTest.directory?("/var/log/newsletters") }
     end

    logrotate_app "newsletter" do
        cookbook "logrotate"
        path "/var/log/newletters/*.log"
        options ["missingok", "copytruncate", "compress", "notifempty"]
        frequency "daily"
        enable true
        create "0644 nobody root"
        rotate 2
     end


    template "/data/apps/newsletter/current/dfp_settings.py" do
         source "dfp_settings.py.erb"
     owner node[:news][:user]
     group node[:news][:group]
     mode 0644
     variables({
             :news => node[:news]
     })
    end
    tag("newsletter-deployed")
  end
rescue
    untag("newsletter-deployed")
end

bash "setup venv" do
      code <<-EOH
      chown -R #{node[:news][:user]}. #{node[:news][:news_path]}
      EOH
end
