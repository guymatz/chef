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

template "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  owner "root"
  group "root"
  mode 0644
end


