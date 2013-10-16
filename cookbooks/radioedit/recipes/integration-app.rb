#
# Cookbook Name:: radioedit
# Recipe:: integration-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a dev version of the radioedit app server
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

link "#{node[:radioedit][:epona][:path]}/settings.json" do
  to "#{node[:radioedit][:epona][:path]}/shared/settings.json"
  action :create
  owner "ihr-deployer"
  group "ihr-deployer"
  not_if "test -L #{node[:radioedit][:epona][:path]}/shared/settings.json"
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


application "radioedit-core" do
  repository "#{node[:radioedit][:epona][:repo]}"
  revision "#{node[:radioedit][:epona][:intbranch]}"
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
  end
end

# gp adding these templates to a util directory until a way using existing chef resource objects is found.
template "#{node[:radioedit][:epona][:utildir]}/supervisor" do
  source "addenvs-supervisor.initd.erb"
  owner "root"
  group "root"
  mode 0755
end

template "#{node[:radioedit][:epona][:utildir]}/radioedit.conf" do
  source "radioedit-nginx.conf.erb"
  owner "root"
  group "root"
  mode 0666
end

template "#{node[:radioedit][:epona][:utildir]}/upd_confs.sh" do
  source "reset-configs.sh.erb"
  owner "root"
  group "root"
  mode 0755
end


#GP hackety hack hack - @TODO Templatize what this script does
execute "reset-confs" do
  command "#{node[:radioedit][:epona][:utildir]}/upd_confs.sh"
  action :run
end








