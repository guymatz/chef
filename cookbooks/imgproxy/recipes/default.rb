#
# Cookbook Name:: imgproxy
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config['file_cache_path']}/varnish_repo.rpm" do
  source node[:varnish_repo]
end

rpm_package "varhnish_repo" do
  action :install
  options "--nosignature"
  source "#{Chef::Config['file_cache_path']}/varnish_repo.rpm"
end

include_recipe "yum::epel"

node[:pkgs].each do |pkg|
  package pkg
end

include_recipe "python::pip"

node[:pips].each do |pip|
  python_pip pip do
    action :install
    if pip.include?("pyparsing")
      version "1.5.7"
    end
  end
end

node[:imgproxy][:static_files].each do |dest,src|
  cookbook_file "#{dest}" do
    source "#{src}"
    if dest.include?("init") || dest.include?("py")
      mode "755"
    end
    if dest.include?("keep_agent")
      mode "440"
    end
  end
end

node[:imgproxy][:template_files].each do |dest,src|
  template "#{dest}" do
    source "#{src}"
  end
end

bash "install_supervisor_service" do
  user "root"
  code "chkconfig --add supervisor"
end

directory node[:supervisor][:process_dir]
node[:supervisor][:run_dirs].each do |dir|
  directory dir
end
directory node[:nginx][:web_dir] do
  owner "nginx"
  group "nginx"
end

template "#{node[:supervisor][:process_dir]}/imgproxy.conf" do
  source "supervisor.conf.erb"
  variables(:name => "imgproxy")
  notifies :reload, "service[supervisor]"
end

template "#{node[:nginx][:web_dir]}/imgproxy.conf" do
  source "nginx.conf.erb"
  owner "nginx"
  group "nginx"
  variables(:name => "imgproxy", :port => 8000)
  notifies :reload, "service[nginx]"
end

service "nginx" do
  action [:enable, :start]
end

service "supervisor" do
  action [:enable, :start]
end
