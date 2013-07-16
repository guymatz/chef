#
# Cookbook Name:: imgscaler
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "java-1.6.0-openjdk"
package "ImageMagick"
package "nfs-utils"

user "tomcat" do
  home "/home/tomcat"
  shell "/bin/bash"
end

directory "/usr/local/tomcat7" do
  owner "tomcat"
  group "tomcat"
  action :create
end

directory "/var/run/tomcat" do
  owner "tomcat"
  group "tomcat"
  action :create
end

directory "/opt/telecom" do
  owner "tomcat"
  group "tomcat"
  action :create
end

directory "/opt/telecom/filecache" do
  owner "tomcat"
  group "tomcat"
  action :create
end

cookbook_file "#{Chef::Config[:file_cache_path]}/imgscaler.tar.gz" do
  source "imgscaler.tar.gz"
  owner "tomcat"
  action :create
  not_if { node.normal.attribute?("imgscaler_deployed") }
end

bash "extract_tomcat" do
  user "tomcat"
  cwd "/usr/local/tomcat7"
  code <<-EOH
  tar xpf #{Chef::Config[:file_cache_path]}/imgscaler.tar.gz
  EOH
  not_if { node.normal.attribute?("imgscaler_deployed") }
end

template "/usr/local/tomcat7/lib/imgscale-env.properties" do
  owner "tomcat"
  group "tomcat"
  source "imgscale-env.properties"
  not_if { node.normal.attribute?("imgscaler_deployed") }
end

cookbook_file "/etc/init.d/tomcat" do
  source "tomcat"
  mode 0755
  action :create
  not_if { node.normal.attribute?("imgscaler_deployed") }
end

bash "install_tomcat_service" do
  user "root"
  code <<-EOH
  chown -R tomcat:tomcat /usr/local/tomcat7
  chkconfig --add tomcat
  service tomcat start
  EOH
  not_if { node.normal.attribute?("imgscaler_deployed") }
end

bash "delete_old_logs" do
  user "tomcat"
  cwd "/usr/local/tomcat7/logs"
  code "find . -mtime +3 -exec rm {} \\;"
end

# Not working :-(
#service "tomcat" do
#  action :start
#end

ruby_block "set_deploy_flag" do
  block do
    node.set['imgscaler_deployed'] = true
    node.save
  end
end
