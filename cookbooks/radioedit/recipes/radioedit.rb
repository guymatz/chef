#
# Cookbook Name:: radioedit
# Recipe:: radioedit
#
#
#
# All rights reserved - Do Not Redistribute
# Installs/deploys the radioedit app server
#
#
# authors: gpatmore, jderagon
# 
#  Sun Feb 23 13:50:23 EST 2014
#  Major refactor to inplement LWRP for spining up hosts.  Starting with HAN release it is splitting
#  the app into services that (for now) are running on the same host, but in the future can possibly be
#  run on seperate hosts.  
## dev testing
untag("radioedit.api_api")


# The default recipe sets up the requirements (I think) that are required for all physical hosts running
# radioedit code.   It does things like:
#
# Setup directories
# Install packages
# Disables or enables services 
#

# 
# make all required directories
# 
node[:radioedit][:req_dirs].each do |d|
  directory d do
    owner node[:radioedit][:app_user]
    group node[:radioedit][:app_user]
    recursive true
  end
end

#
# all the packages, right now we are just assuming we install all packages on everything
# eventually if we split off hosts, we may want to make the packages specific to what that app is doing
# 
node[:radioedit][:packages].each do |p|
  package p
end

#
# startup services 
# 
%w{ nginx varnish memcached }.each do |serv|
  service serv do
    supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
end

#
# disable varnish log
#
service "varnishlog" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :disable, :stop ]
end



# TODO WHERE DOES THIS GO
#template "#{node[:radioedit][:path]}/shared/settings.json" do
#  source "settings.json.erb"
#  owner node[:radioedit][:app_user]
#  group node[:radioedit][:app_user]
#end

# TODO THIS TOO
#link "#{node[:radioedit][:path]}/settings.json" do
#  to "#{node[:radioedit][:path]}/shared/settings.json"
#  action :create
#  owner node[:radioedit][:app_user]
#  group node[:radioedit][:app_user]
#  not_if "test -L #{node[:radioedit][:path]}/shared/settings.json"
#end

# reset ownership to nginx to allow static file serving
directory "#{node[:radioedit][:app_api][:staticdir]}" do
  owner "nginx"
  group "nginx"
  recursive true
end

# ###############################################################
# static files served through a redirect in nginx conf file 
# ###############################################################

#template "#{node[:radioedit][:legacy_root]}/android.json" do
#  source "staticfile-android.json.erb"
#  owner "nginx"
#  group "nginx"
#  mode 0444
#end
#
#template "#{node[:radioedit][:legacy_root]}/fux.json" do
#  source "staticfile-fux.json.erb"
#  owner "nginx"
#  group "nginx"
#  mode 0444 
#end
#
#template "#{node[:radioedit][:legacy_root]}/iphone.json" do
#  source "staticfile-iphone.json.erb"
#  owner "nginx"
#  group "nginx"
#  mode 0444
#end
#
#template "#{node[:radioedit][:legacy_root]}/kenwood.json" do
#  source "staticfile-kenwood.json.erb"
#  owner "nginx"
#  group "nginx"
#  mode 0444
#end

# ###############################################################
# end static file templates 
# ###############################################################
#
file '/etc/nginx/conf.d/default.conf' do
   action :delete
   only_if "test -f /etc/nginx/conf.d/default.conf"
end

template "/etc/varnish/default.vcl" do
  source "varnish.vcl.erb"
  owner "root"
  group "root"
  mode 0600
  variables({
    :host => node[:radioedit][:varnish_backend_ip],
    :port => node[:radioedit][:varnish_backend_port],
    :statsd_host => node[:radioedit][:statsd_host]
  })
end

template "/etc/sysconfig/varnish" do
  source "varnish_sysconfig"
  owner "root"
  group "root"
  mode 0644
end

#NOTE NOTE NOTE: This is DELETING an nginx config file.  Needed for use with the Han Release
template "/etc/nginx/conf.d/radioedit.conf" do
  source "nginx.refactor.conf.erb"
  owner "root"
  group "root"
  mode 0666
  action :delete
  notifies :reload, "service[nginx]", :immediately
end

service "varnish" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [ :restart ]
end

