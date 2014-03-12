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
    action :init
    #not_if { node.tags.include?(radioedit.app-script) }
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
