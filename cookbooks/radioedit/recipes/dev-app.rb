#
# Cookbook Name:: radioedit
# Recipe:: dev-app
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# Installs requirements for a dev version of an app server
#

include_recipe "yum::epel"

# add sudo for trey long
sudo "tlong" do
  user "tlong"
  commands ["ALL"]
  runas "root"
  nopasswd true
end

sudo "ikaprizkina" do
  user "ikaprizkina"
  commands ["ALL"]
  runas "root"
  nopasswd true
end

# make a directory to stash builds in 
%w{ /data /data/apps /data/apps/radioedit /root/build /data/apps/radioedit/envs /data/apps/radioedit/envs/radioedit }.each do |d|
  directory d do
    owner "gpatmore"
    group "gpatmore"
    action :create
  end
end

# need to install the memcached package as a dep of libmemcached 
yum_package "memcached" do
  arch "x86_64"
  action [ :install, :upgrade ]
end

# install libmemcached from source 
# @TODO: change to rpm install 
remote_file "/root/build/libmemcached-0.51.tar.gz" do
  source "https://launchpad.net/libmemcached/1.0/0.51/+download/libmemcached-0.51.tar.gz"
  notifies :run, "bash[install_libmemcached]", :immediately
end

bash "install_libmemcached" do
  user "root"
  cwd "/root/build"
  code <<-EOH
    tar -zxf libmemcached-0.51.tar.gz
    (cd libmemcached-0.51/ && ./configure && make && make install)
  EOH
  action :nothing
end

python_virtualenv "#{node[:radioedit][:epona][:path]}/envs/radioedit" do
  interpreter "python27"
  owner "gpatmore"
  group "gpatmore"
  action :create
end

node[:radioedit][:epona][:packages].each  { |p| package p }
node[:radioedit][:epona][:pips].each      { |p| python_pip p }

application "radioedit-cms" do
  repository "#{node[:radioedit][:epona][:repo]}"
  revision "#{node[:radioedit][:epona][:branch]}"
  path "#{node[:radioedit][:epona][:path]}"
  owner "gpatmore"
  group "gpatmore"

  gunicorn do
    app_module 'wsgi:application'
    Chef::Log.info("Starting up Gunicorn on port #{node[:radioedit][:epona][:port]} for Radioedit-Epona")
    port node[:radioedit][:epona][:port] 
    workers 10
    host node[:radioedit][:epona][:host]
    pidfile "/var/run/radioedit/radioedit-epona.pid"
    virtualenv "#{node[:radioedit][:epona][:path]}/envs/radioedit"
  end
end





