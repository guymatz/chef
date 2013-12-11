#
# Cookbook Name:: radioedit
# Recipe:: staging-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a production version of the radioedit app server
#

include_recipe "yum::epel"

# make all required directories
node[:radioedit][:staging][:req_dirs].each do |d|
  directory d do
    owner "ihr-deployer"
    group "ihr-deployer"
    action :create
  end
end

node[:radioedit][:staging][:packages].each do |p|
  yum_package p do
    action [ :install, :upgrade ]
  end
end

%w{ nginx varnish varnishlog }.each do |serv|
  service serv do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
end

template "#{node[:radioedit][:staging][:path]}/shared/settings.json" do
  source "staging-settings.json.erb"
  owner "ihr-deployer"
  group "ihr-deployer"
end

link "#{node[:radioedit][:staging][:path]}/settings.json" do
  to "#{node[:radioedit][:staging][:path]}/shared/settings.json"
  action :create
  owner "ihr-deployer"
  group "ihr-deployer"
  not_if "test -L #{node[:radioedit][:staging][:path]}/shared/settings.json"
end

python_virtualenv "#{node[:radioedit][:staging][:venv_path]}" do
  interpreter "python27"
  owner "ihr-deployer"
  group "ihr-deployer"
  action :create
end

application "radioedit-core" do
  repository "#{node[:radioedit][:staging][:repo]}"
  revision "#{node[:radioedit][:staging][:branch]}"
  path "#{node[:radioedit][:staging][:path]}"
  owner "ihr-deployer"
  group "ihr-deployer"
  enable_submodules true

  gunicorn do
    app_module "#{node[:radioedit][:staging][:module]}"
    port node[:radioedit][:staging][:port]
    host node[:radioedit][:staging][:host]
    workers node[:radioedit][:staging][:num_workers]
    pidfile node[:radioedit][:staging][:pid_file]
    virtualenv "#{node[:radioedit][:staging][:venv_path]}"
    stdout_logfile "#{node[:radioedit][:staging][:out_log]}"
    stderr_logfile "#{node[:radioedit][:staging][:err_log]}"
    packages node[:radioedit][:staging][:pips]
    loglevel "#{node[:radioedit][:staging][:log_level]}"
    interpreter "python27"
  end
end

template "/etc/nginx/conf.d/radioedit.conf" do
  source "staging-nginx.conf.erb"
  owner "root"
  group "root"
  mode 0666
  notifies :reload, "service[nginx]", :immediately
end

# reset ownership to nginx to allow static file serving
directory "#{node[:radioedit][:staging][:staticdir]}" do
    owner "nginx"
    group "nginx"
end

template "#{node[:radioedit][:staging][:staticdir]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:staging][:staticdir]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444 
end

template "#{node[:radioedit][:staging][:staticdir]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:staging][:staticdir]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end
