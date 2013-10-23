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
node[:radioedit][:bob][:req_dirs].each do |d|
  directory d do
    owner "ihr-deployer"
    group "ihr-deployer"
    action :create
  end
end

node[:radioedit][:bob][:packages].each do |p|
  yum_package p do
    action [ :install, :upgrade ]
  end
end

template "#{node[:radioedit][:bob][:path]}/shared/settings.json" do
  source "production-settings.json.erb"
  owner "ihr-deployer"
  group "ihr-deployer"
end

link "#{node[:radioedit][:bob][:path]}/settings.json" do
  to "#{node[:radioedit][:bob][:path]}/shared/settings.json"
  action :create
  owner "ihr-deployer"
  group "ihr-deployer"
  not_if "test -L #{node[:radioedit][:bob][:path]}/shared/settings.json"
end



python_virtualenv "#{node[:radioedit][:bob][:venv_path]}" do
  interpreter "python27"
  owner "ihr-deployer"
  group "ihr-deployer"
  action :create
end


application "radioedit-core" do
  repository "#{node[:radioedit][:bob][:repo]}"
  revision "#{node[:radioedit][:bob][:branch]}"
  path "#{node[:radioedit][:bob][:path]}"
  owner "ihr-deployer"
  group "ihr-deployer"
  enable_submodules true

  gunicorn do
    app_module 'wsgi'
    port node[:radioedit][:bob][:port]
    host node[:radioedit][:bob][:host]
    workers node[:radioedit][:bob][:num_workers]
    pidfile node[:radioedit][:bob][:pid_file]
    virtualenv "#{node[:radioedit][:bob][:venv_path]}"
    stdout_logfile "#{node[:radioedit][:bob][:out_log]}"
    stderr_logfile "#{node[:radioedit][:bob][:err_log]}"
    packages node[:radioedit][:bob][:pips]
    loglevel "DEBUG"
    interpreter "python27"
  end
end

# gp adding these templates to a util directory until a way using existing chef resource objects is found.
template "#{node[:radioedit][:bob][:utildir]}/supervisor" do
  source "dev-supervisor.initd.erb"
  owner "root"
  group "root"
  mode 0755
  action [:create]
end

template "#{node[:radioedit][:bob][:utildir]}/radioedit.conf" do
  source "dev-radioedit.conf.erb"
  owner "root"
  group "root"
  mode 0666
  action [:create]
end

template "#{node[:radioedit][:bob][:utildir]}/upd_confs.sh" do
  source "dev-reset-configs.sh.erb"
  owner "root"
  group "root"
  mode 0755
  action [:delete,:create]
end

# reset ownership to nginx to allow static file serving
directory "#{node[:radioedit][:bob][:staticdir]}" do
    owner "nginx"
    group "nginx"
    action :create
  end

template "#{node[:radioedit][:bob][:staticdir]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [:delete, :create]
end

template "#{node[:radioedit][:bob][:staticdir]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444 
  action [:delete, :create]
end

template "#{node[:radioedit][:bob][:staticdir]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [:delete, :create]
end

template "#{node[:radioedit][:bob][:staticdir]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
  action [:delete, :create]
end


#GP hackety hack hack - @TODO Templatize what this script does
execute "reset-confs" do
  command "#{node[:radioedit][:bob][:utildir]}/upd_confs.sh"
  action :run
end








