#
# Cookbook Name:: radioedit
# Recipe:: radioedit
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs/deploys the radioedit app server
#

# make all required directories
node[:radioedit][:req_dirs].each do |d|
  directory d do
    owner node[:radioedit][:app_user]
    group node[:radioedit][:app_user]
  end
end

node[:radioedit][:packages].each do |p|
  yum_package p
end

%w{ nginx varnish varnishlog }.each do |serv|
  service serv do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
end

template "#{node[:radioedit][:path]}/shared/settings.json" do
  source "settings.json.erb"
  owner node[:radioedit][:app_user]
  group node[:radioedit][:app_user]
end

link "#{node[:radioedit][:path]}/settings.json" do
  to "#{node[:radioedit][:path]}/shared/settings.json"
  action :create
  owner node[:radioedit][:app_user]
  group node[:radioedit][:app_user]
  not_if "test -L #{node[:radioedit][:path]}/shared/settings.json"
end

# reset ownership to nginx to allow static file serving
directory "#{node[:radioedit][:staticdir]}" do
  owner "nginx"
  group "nginx"
end

# ###############################################################
# static files served through a redirect in nginx conf file 
# ###############################################################

template "#{node[:radioedit][:staticdir]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:staticdir]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444 
end

template "#{node[:radioedit][:staticdir]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:staticdir]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

# ###############################################################
# end static file templates 
# ###############################################################

log "Deploying #{node[:radioedit][:branch]}"

unless tagged?("radioedit-deployed" && node.chef_environment == "prod")
  application "radioedit-core" do
    repository node[:radioedit][:repo]
    revision node[:radioedit][:branch]
    path node[:radioedit][:path]
    owner node[:radioedit][:app_user]
    group node[:radioedit][:app_user]
    enable_submodules true
  
    gunicorn do
      app_module node[:radioedit][:module]
      port node[:radioedit][:port]
      host node[:radioedit][:host]
      workers node[:radioedit][:num_workers]
      pidfile node[:radioedit][:pid_file]
      stdout_logfile node[:radioedit][:out_log]
      stderr_logfile node[:radioedit][:err_log]
      packages node[:radioedit][:pips]
      loglevel node[:radioedit][:log_level]
      interpreter "python27"
      autostart true
      virtualenv node[:radioedit][:venv_path]
      environment ({"ENVIRONMENT" => node[:radioedit][:env],
                   "APP_ENV" => node[:radioedit][:env]})
    end
  end
  tag("radioedit-deployed")
end

template "/etc/varnish/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0600
  variables({
    :host => node[:radioedit][:varnish_backend_ip],
    :port => node[:radioedit][:varnish_backend_port]
  })
  notifies :reload, "service[varnish]", :immediately
end

template "/etc/nginx/conf.d/radioedit.conf" do 
  source "nginx.refactor.conf.erb" 
  owner "root" 
  group "root" 
  mode 0666 
  notifies :reload, "service[nginx]", :immediately 
end

logrotate_app "varnish" do
  cookbook "logrotate"
  path "/var/log/varnish/varnish.log"
  options ["missingok", "compress", "notifempty", "sharedscripts","dateext"]
  frequency "daily"
  enable true
  rotate 5
  size "2G"
  postrotate '    /bin/kill -HUP `cat /var/run/varnishlog.pid 2>/dev/null` 2> /dev/null || true
    /bin/kill -HUP `cat /var/run/varnishncsa.pid 2>/dev/null` 2> /dev/null || true'
end
#  size (1024**2)*2 # 2MB
#  #  postrotate "find #{node[:apache][:log_dir]} -name '*.gz*' -exec rm -rf {} \\;
#  "
