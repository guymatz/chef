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
  not_if { node.attribute?("imgproxy_deployed") }
end

rpm_package "varhnish_repo" do
  action :install
  options "--nosignature"
  source "#{Chef::Config['file_cache_path']}/varnish_repo.rpm"
  not_if { node.attribute?("imgproxy_deployed") }
end

include_recipe "yum::epel"

node[:pkgs].each do |pkg|
  package pkg do
    action :install
    not_if { node.attribute?("imgproxy_deployed") }
  end
end

include_recipe "python::pip"

node[:pips].each do |pip|
  python_pip pip do
    action :install
    if pip.include?("pyparsing")
      version "1.5.7"
    end
    not_if { node.attribute?("imgproxy_deployed") }
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

directory node[:supervisor][:imgproxy][:dir]

cookbook_file "#{node[:supervisor][:imgproxy][:dir]}/imgproxy.tar.gz" do
  source "imgproxy.tar.gz"
end

bash "deploy_imgproxy" do
  cwd "#{node[:supervisor][:imgproxy][:dir]}"
  code "tar xpf imgproxy.tar.gz"
  not_if { node.attribute?("imgproxy_deployed") }
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

service "nginx" do
  action [:enable, :start]
end

service "supervisor" do
  action [:enable, :start]
end

service "varnish" do
  action [:enable, :start]
end

template "#{node[:supervisor][:process_dir]}/imgproxy.conf" do
  source "supervisor.conf.erb"
  variables(:name => "imgproxy")
  notifies :restart, "service[supervisor]"
end

template "#{node[:nginx][:web_dir]}/imgproxy.conf" do
  source "nginx.conf.erb"
  owner "nginx"
  group "nginx"
  variables(:name => "imgproxy", :port => 8000)
  notifies :restart, "service[nginx]"
end

ruby_block "deployed_flag" do
  block do
    node.set['imgproxy_deployed'] = true
    node.save
  end
end
