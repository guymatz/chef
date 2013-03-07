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

cookbook_file "#{Chef::Config[:file_cache_path]}/imgscaler.tar.gz" do
  source "imgscaler.tar.gz"
  action :create
end

directory "/usr/local/tomcat7" do
  owner "tomcat"
  group "tomcat"
  action :create
end

bash "extract_tomcat" do
  user "tomcat"
  cwd "/usr/local/tomcat7"
  code <<-EOH
  tar xpf #{Chef::Config[:file_cache_path]}/imgscaler.tar.gz
  EOH
end

cookbook_file "/etc/init.d/tomcat" do

end
