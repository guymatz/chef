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

    user node[:radioedit][:app_auth][:user_name]
    host node[:radioedit][:app_auth][:host]
    port node[:radioedit][:app_auth][:port]
    app_module node[:radioedit][:app_auth][:module]
    webserver_listen node[:radioedit][:app_auth][:nginx_listen]
    webserver_name node[:radioedit][:app_auth][:webserver_name]
    log_level node[:radioedit][:app_auth][:log_level]
    pid_file node[:radioedit][:app_auth][:pid_file]
    stdout_log "#{node[:radioedit][:log_dir]}/app_auth.out"
    stderr_log "#{node[:radioedit][:log_dir]}/app_auth.err"
    root_dir node[:radioedit][:app_auth][:root_dir]
    venv_dir "#{node[:radioedit][:app_auth][:root_dir]}/env"
    src_dir "#{node[:radioedit][:app_auth][:root_dir]}/releases"
    repository node[:radioedit][:app_auth][:repo]
    revision node[:radioedit][:app_auth][:deploy_revision]
    enable_submodules true
    workers node[:radioedit][:app_auth][:num_workers]
    environment node[:radioedit][:app_auth][:environment]
    autostart true
    deploy_tag node[:radioedit][:app_auth][:deploy_tag]

end

# NOTE THE CHANGE IN - to _
template "/etc/nginx/conf.d/app-script.conf" do
  source "nginx-app_script.conf.erb"
  owner "root"
  group "root"
  mode 0600
  variables({
      :webserver_port =>      node[:radioedit][:app_script][:nginx_listen],
  })
  notifies :reload, "service[nginx]", :immediately
end
