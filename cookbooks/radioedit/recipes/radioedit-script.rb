#
# Cookbook Name:: radioedit-auth
# Recipe:: radioedit-auth
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
#  Stub to setup the auth service
## dev testing
untag("radioedit.app-script")

service "nginx" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable ]
end

#
# we nneed to make sure we have nodejs and npm
#
# NO WE DONT.  I created a 
# include_recipe "nodejs::default"

#
# call the provider for app-auth
#
radioedit_node "app_script" do

    not_if { node.chef_environment =~ /^prod/ && node.tags.include?(node[:radioedit][:app_script][:deploy_tag]) }

    user node[:radioedit][:app_script][:user_name]
    host node[:radioedit][:app_script][:host]
    port node[:radioedit][:app_script][:port]
    webserver_listen node[:radioedit][:app_script][:nginx_listen]
    webserver_name node[:radioedit][:app_script][:webserver_name]
    log_level node[:radioedit][:app_script][:log_level]
    pid_file node[:radioedit][:app_script][:pid_file]
    stdout_log "#{node[:radioedit][:log_dir]}/app_script.out"
    stderr_log "#{node[:radioedit][:log_dir]}/app_script.err"
    root_dir node[:radioedit][:app_script][:root_dir]
    venv_dir "#{node[:radioedit][:app_script][:root_dir]}/env"
    src_dir "#{node[:radioedit][:app_script][:root_dir]}/releases"
    repository node[:radioedit][:app_script][:repo]
    revision node[:radioedit][:app_script][:deploy_revision]
    enable_submodules true
    environment node[:radioedit][:app_script][:environment]
    autostart true
    deploy_tag node[:radioedit][:app_script][:deploy_tag]

end

