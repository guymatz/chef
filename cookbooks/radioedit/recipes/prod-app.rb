#
# Cookbook Name:: radioedit
# Recipe:: prod-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a production version of the radioedit app server
#

include_recipe "yum::epel"

# make all required directories
node[:radioedit][:production][:req_dirs].each do |d|
  directory d do
    owner "ihr-deployer"
    group "ihr-deployer"
    action :create
  end
end

node[:radioedit][:production][:packages].each do |p|
  yum_package p do
    action [ :install, :upgrade ]
  end
end

template "#{node[:radioedit][:production][:path]}/shared/settings.json" do
  source "production-settings.json.erb"
  owner "ihr-deployer"
  group "ihr-deployer"
end

link "#{node[:radioedit][:production][:path]}/settings.json" do
  to "#{node[:radioedit][:production][:path]}/shared/settings.json"
  action :create
  owner "ihr-deployer"
  group "ihr-deployer"
  not_if "test -L #{node[:radioedit][:production][:path]}/shared/settings.json"
end

# execute "set-app-env" do
#   command "/data/apps/radioedit/setenv.sh"
#   action :nothing
# end

# template "/data/apps/radioedit/setenv.sh" do
#   source "production-env.sh.erb"
#   owner "ihr-deployer"
#   group "ihr-deployer"
#   mode 0755
#   notifies :run, "execute[set-app-env]", :immediately
# end


python_virtualenv "#{node[:radioedit][:production][:venv_path]}" do
  interpreter "python27"
  owner "ihr-deployer"
  group "ihr-deployer"
  action :create
end


application "radioedit-core" do
  repository "#{node[:radioedit][:production][:repo]}"
  revision "#{node[:radioedit][:production][:branch]}"
  path "#{node[:radioedit][:production][:path]}"
  owner "ihr-deployer"
  group "ihr-deployer"
  enable_submodules true

  gunicorn do
    app_module 'wsgi'
    port node[:radioedit][:production][:port]
    host node[:radioedit][:production][:host]
    workers node[:radioedit][:production][:num_workers]
    pidfile node[:radioedit][:production][:pid_file]
    virtualenv "#{node[:radioedit][:production][:venv_path]}"
    stdout_logfile "#{node[:radioedit][:production][:out_log]}"
    stderr_logfile "#{node[:radioedit][:production][:err_log]}"
    packages node[:radioedit][:production][:pips]
    loglevel "DEBUG"
    interpreter "python27"
  end
end

# gp adding these templates to a util directory until a way using existing chef resource objects is found.
template "#{node[:radioedit][:production][:utildir]}/supervisor" do
  source "addenvs-supervisor.initd.erb"
  owner "root"
  group "root"
  mode 0755
  action [ :delete, :create ]
end

template "#{node[:radioedit][:production][:utildir]}/radioedit.conf" do
  source "prod-radioedit.conf.erb"
  owner "root"
  group "root"
  mode 0666
  action [ :delete, :create ]
end

template "#{node[:radioedit][:production][:utildir]}/upd_confs.sh" do
  source "prod-reset-configs.sh.erb"
  owner "root"
  group "root"
  mode 0755
  action [ :delete, :create ]
end

# reset ownership to nginx to allow static file serving
directory "#{node[:radioedit][:production][:staticdir]}" do
    owner "nginx"
    group "nginx"
    action :create
  end

template "#{node[:radioedit][:production][:staticdir]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [ :delete, :create ]
end

template "#{node[:radioedit][:production][:staticdir]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444 
  action [ :delete, :create ]
end

template "#{node[:radioedit][:production][:staticdir]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [ :delete, :create ]
end

template "#{node[:radioedit][:production][:staticdir]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [ :delete, :create ]
end


#GP hackety hack hack - @TODO Templatize what this script does
execute "reset-confs" do
  command "#{node[:radioedit][:production][:utildir]}/upd_confs.sh"
  action :run
end








