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
    recursive true
  end
end

node[:radioedit][:packages].each do |p|
  package p
end

%w{ nginx varnish memcached }.each do |serv|
  service serv do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
end

service "varnishlog" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :disable, :stop ]
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
  recursive true
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

unless tagged?("radioedit-deployed") && node.chef_environment == "prod"
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
  tag("radioedit-deployed") if node.chef_environment == "prod"
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
  notifies :restart, "service[varnish]", :immediately
end

template "/etc/sysconfig/varnish" do
  source "varnish_sysconfig"
  owner "root"
  group "root"
  mode 0644 
  notifies :reload, "service[varnish]", :immediately 
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  owner "root"
  group "root"
  mode 0644
end

# gp added to remove default.conf file dropped by the rpm.
file '/etc/nginx/conf.d/default.conf' do
  action :delete
  only_if "test -f /etc/nginx/conf.d/default.conf"
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
