#
# Cookbook Name:: imgscaler
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "jdK"

user tomcat do
  home "/home/tomcat"
  shell "/bin/bash"
end

directory "/usr/local/tomcat7" do
  owner "tomcat"
  group "tomcat"
  action :create
end

cookbook_file "#{Chef::Config[:file_cache_path]}/imgscaler.tar.gz" do
  source "imgscaler.tar.gz"
  action :create
  not_if { node.attribute?("imgproxy_deployed") }
end

bash "extract_tomcat" do
  user "tomcat"
  cwd "/usr/local/tomcat7"
  code <<-EOH
  tar xpf #{Chef::Config[:file_cache_path]}/imgscaler.tar.gz
  EOH
  not_if { node.attribute?("imgproxy_deployed") }
end

cookbook_file "/etc/init.d/tomcat" do
  source "tomcat"
  mode 0755
  action :create
  not_if { node.attribute?("imgproxy_deployed") }
end

bash "install_tomcat_service" do
  user "root"
  code <<-EOH
  chkconfig --add tomcat
  EOH
  not_if { node.attribute?("imgproxy_deployed") }
end

service "tomcat" do
  action [ :enable, :start ]
end

ruby_block "set_deploy_flag" do
  block do
    node.set['imgproxy_deployed'] = true
    node.save
  end
  action :nothing
end
