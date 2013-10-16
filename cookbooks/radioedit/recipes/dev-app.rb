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
  yum_package p do
    action [ :install, :upgrade ]
  end
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


python_virtualenv "#{node[:radioedit][:epona][:venv_path]}" do
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

# link "/usr/local/bin/supervisorctl" do
#   to "/data/apps/radioedit/envs/core/bin/supervisorctl"
#   action :create
#    not_if "test -L /usr/local/bin/supervisorctl"
# end

application "radioedit-core" do
  repository "#{node[:radioedit][:epona][:repo]}"
  revision "#{node[:radioedit][:epona][:branch]}"
  path "#{node[:radioedit][:epona][:path]}"
  owner "ihr-deployer"
  group "ihr-deployer"
  enable_submodules true

  gunicorn do
    app_module 'wsgi'
    port node[:radioedit][:epona][:port]
    host node[:radioedit][:epona][:host]
    workers node[:radioedit][:epona][:num_workers]
    pidfile node[:radioedit][:epona][:pid_file]
    virtualenv "#{node[:radioedit][:epona][:venv_path]}"
    stdout_logfile "#{node[:radioedit][:epona][:out_log]}"
    stderr_logfile "#{node[:radioedit][:epona][:err_log]}"
    packages node[:radioedit][:epona][:pips]
    loglevel "DEBUG"
    interpreter "python27"
    raw_env "ENVIRONMENT=ihr_testing"
  end
end







