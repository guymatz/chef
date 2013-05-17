node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
include_recipe "java"
include_recipe "tomcat7"

download_url = "#{node[:fbtomcat][:url]}/facebook-1.0.0-#{node[:fbtomcat][:version]}.war"

remote_file "#{node[:tomcat7][:webapp_dir]}/face.war" do
  Chef::Log.info("Installing fbtomcat.war from #{download_url}")
  source download_url
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  action :create_if_missing
  only_if "test -d #{node[:tomcat7][:webapp_dir]}"
  notifies :restart, "service[tomcat]", :immediately
end

template "#{node[:tomcat7][:install_path]}/lib/env.properties" do
  source "env.properties.erb"
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  mode "0755"
end

directory "/var/run/tomcat" do
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  recursive true
end

service "tomcat" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end
