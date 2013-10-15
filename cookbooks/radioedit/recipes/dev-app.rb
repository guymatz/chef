#
# Cookbook Name:: radioedit
# Recipe:: dev-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a dev version of an app server
#

include_recipe "yum::epel"

# make all required directories
node[:radioedit][:epona][:req_dirs].each do |d|
  directory d do
    owner "ihr-deployer"
    group "ihr-deployer"
    action :create
  end
end

node[:radioedit][:epona][:packages].each do |p|
  arch "x86_64"
  action :install
end

template "#{node[:radioedit][:epona][:path]}/shared/settings.json" do
  source "epona-settings.json.erb"
  owner "ihr-deployer"
  group "ihr-deployer"
end

execute "set-app-env" do
  command "/data/apps/radioedit/setenv.sh"
  action :nothing
end

template "/data/apps/radioedit/setenv.sh" do
  source "epona-env.sh.erb"
  owner "ihr-deployer"
  group "ihr-deployer"
  mode 0755
  notifies :run, "execute[set-app-env]", :immediately
end


# need to install the memcached package as a dep of libmemcached 
yum_package "memcached" do
  arch "x86_64"
  action [ :install, :upgrade ]
end


python_virtualenv "#{node[:radioedit][:epona][:path]}/envs/core" do
  interpreter "python27"
  owner "ihr-deployer"
  group "ihr-deployer"
  action :create
end

node[:radioedit][:epona][:packages].each  { |p| package p }
node[:radioedit][:epona][:pips].each { |p| 
  python_pip p do 
    virtualenv "#{node[:radioedit][:epona][:venv_path]}"
    action :install
  end
}

application "radioedit-core" do
  repository "#{node[:radioedit][:epona][:repo]}"
  revision "#{node[:radioedit][:epona][:branch]}"
  path "#{node[:radioedit][:epona][:path]}"
  owner "ihr-deployer"
  group "ihr-deployer"
  enable_submodules true

  gunicorn do
    app_module 'wsgi:application'
    Chef::Log.info("Starting up Gunicorn on port #{node[:radioedit][:epona][:port]} for Radioedit-Epona")
    port node[:radioedit][:epona][:port] 
    workers node[:radioedit][:epona][:num_workers]
    host node[:radioedit][:epona][:host]
    pidfile node[:radioedit][:epona][:pid_file]
    virtualenv "#{node[:radioedit][:epona][:venv_path]}"
    stdout_logfile "#{node[:radioedit][:epona][:out_log]}"
    stderr_logfile "#{node[:radioedit][:epona][:err_log]}"
    loglevel "DEBUG"
  end
end







