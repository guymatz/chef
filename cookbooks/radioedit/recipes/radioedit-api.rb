#
# Cookbook Name:: radioedit-api
# Recipe:: radioedit-api
#
#
#
# All rights reserved - Do Not Redistribute
# Installs/deploys the radioedit app server
#
#
# authors:  jderagon
# 
#  Sun Feb 23 13:50:23 EST 2014
# 
#  Stub to setup the api service

service "nginx" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable ]
end

radioedit_unicorn "app_api" do

    not_if { node.chef_environment =~ /^prod/ && node.tags.include?(node[:radioedit][:app_api][:deploy_tag]) }

    user node[:radioedit][:app_api][:user_name]

    host node[:radioedit][:app_api][:host]
    port node[:radioedit][:app_api][:port]

    app_module node[:radioedit][:app_api][:module]

    webserver_listen node[:radioedit][:app_api][:nginx_listen]
    
    webserver_name node[:radioedit][:app_api][:webserver_name]

    log_level node[:radioedit][:app_api][:log_level]
    pid_file node[:radioedit][:app_api][:pid_file]

    stdout_log "#{node[:radioedit][:log_dir]}/app_api.out"
    stderr_log "#{node[:radioedit][:log_dir]}/app_api.err"

    root_dir node[:radioedit][:app_api][:root_dir]
    venv_dir "#{node[:radioedit][:app_api][:root_dir]}/env"
    src_dir "#{node[:radioedit][:app_api][:root_dir]}/releases"

    repository node[:radioedit][:app_api][:repo]
    revision node[:radioedit][:app_api][:deploy_revision]
    enable_submodules true

    workers node[:radioedit][:app_api][:num_workers]
    environment node[:radioedit][:app_api][:environment]
    autostart true
    
    deploy_tag node[:radioedit][:app_api][:deploy_tag]
    
    legacy_static_root node[:radioedit][:app_api][:static_dir]
end


# 
# static files served through a redirect in nginx conf file.
# [this is only on the core/api server]
# 

template "#{node[:radioedit][:legacy_root]}/android.json" do
  source "staticfile-android.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/fux.json" do
  source "staticfile-fux.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/iphone.json" do
  source "staticfile-iphone.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end

template "#{node[:radioedit][:legacy_root]}/kenwood.json" do
  source "staticfile-kenwood.json.erb"
  owner "nginx"
  group "nginx"
  mode 0444
end


service "nginx" do
  action [ :restart ]
end


