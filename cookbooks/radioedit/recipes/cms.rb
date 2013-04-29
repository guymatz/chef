#
# Cookbook Name:: radioedit
# Recipe:: cms
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

# default recipe is also called "radioedit-core"
include_recipe "radioedit::default"

directory "/data"
directory "/data/apps"
directory "/data/apps/radioedit" do
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
end

directory "#{node[:radioedit][:cms][:path]}" do
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
end

node[:radioedit][:cms][:packages].each do |p|
  package p
end

#deploy_brach = node.run_list.include?('role[radioedit_server_a]') ? 'deploy_a_release' : 'deploy'
application "radioedit-cms" do
  repository node[:radioedit][:cms][:repo]
  revision 'deploy'
  path node[:radioedit][:cms][:path]
  owner node[:radioedit][:user]
  group node[:radioedit][:group]
  migrate false
  action :deploy

  django do
    interpreter "python27"
    requirements "requirements.txt"
    debug true
    settings_template "settings.py.erb"
  end

  gunicorn do
    app_module :django
    Chef::Log.info("Starting up Gunicorn on port #{node[:radioedit][:cms][:port]} for Radioedit-CMS")
    port node[:radioedit][:cms][:port]
    workers 10
    host node[:radioedit][:cms][:host]
    pidfile "/var/run/radioedit-cms.pid"
  end

end

service "nginx"

%w{ nginx.conf proxy_params }.each do |conf|
  template "/etc/nginx/#{conf}" do
    source conf
    owner "nginx"
    group "nginx"
  end
end

template "/etc/nginx/conf.d/radioedit-cms.conf" do
  source "nginx_cms.conf"
  owner "nginx"
  group "nginx"
  notifies :reload, 'service[nginx]', :immediately
end

remote_directory "#{node[:radioedit][:cms][:path]}/current/static" do
  files_owner node[:radioedit][:user]
  files_group node[:radioedit][:group]
  source "static"
  not_if { File.exists?('#{node[:radioedit][:cms][:path]}/current/static') }
end

template "/etc/sysconfig/varnish" do
  source "varnish_sysconfig"
end

template "/etc/varnish/default.vcl" do
  source "varnish.vcl"
end
