#
# Cookbook Name:: amp
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
%w{ users::amp java tomcat7 mongosd amp::logging amp::nagios }.each do |r|
  include_recipe r
end

hosts = Hash.new
hosts["mongodb-fac1b01"] = "10.90.47.182"
hosts["mongodb-fac1b02"] = "10.90.47.183"
hosts["mongodb-fac1b03"] = "10.90.47.184"
hosts["mongodb-fac1b04"] = "10.90.47.185"
hosts["mongodb-usr1a01"] = "10.90.47.186"
hosts["mongodb-usr1a02"] = "10.90.47.187"
hosts["mongodb-usr1a03"] = "10.90.47.188"
hosts["mongodb-usr1a04"] = "10.90.47.189"
hosts["mongodb-usr1a05"] = "10.90.47.190"
hosts["mongodb-usr1a06"] = "10.90.47.191"
hosts["cassandra1a01"] = "10.90.49.240"
hosts["cassandra1a02"] = "10.90.49.241"
hosts["cassandra1a03"] = "10.90.49.242"
hosts["cassandra1a04"] = "10.90.49.243"
hosts["cassandra1a05"] = "10.90.49.251"
hosts["rabbitmq-1b-http-vip"] = "10.90.46.252"
hosts["apimemcache1a01"] = "10.90.46.208"
hosts["apimemcache1a02"] = "10.90.46.209"
hosts["apimemcache1a03"] = "10.90.46.210"
hosts["apimemcache1a04"] = "10.90.46.211"

hosts.each do |host,ip|
  hostsfile_entry ip do
    hostname host
  end
end

service "tomcat" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end

begin
  puts "entered begin block"
  unless tagged?("amp-deployed")
    service "tomcat" do
      action :stop
    end

    bash "clear webapps/ROOT" do
      code "rm -rf #{node[:tomcat7][:webapp_dir]}/ROOT/*"
      user "root"
    end

    remote_file "#{node[:tomcat7][:webapp_dir]}/ROOT/crossdomain.xml" do
      source "#{node[:amp][:url]}/crossdomain.xml"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end

    remote_file "#{node[:tomcat7][:webapp_dir]}/api.war" do
      source "#{node[:amp][:url]}/#{node[:amp][:version]}/amp-rest-#{node[:amp][:version]}.war"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end

    remote_file "#{node[:tomcat7][:install_path]}/lib/env.properties" do
      source "#{node[:amp][:url]}/#{node[:amp][:version]}/env.properties"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end

    remote_file "#{node[:tomcat7][:install_path]}/lib/log4j.xml" do
      source "#{node[:amp][:url]}/#{node[:amp][:version]}/log4j.xml"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end

    remote_file "#{Chef::Config[:file_cache_path]}/amplib.tgz" do
      source "#{node[:amp][:url]}/amplib.tgz"
    end

    bash "Extract AMP Libs" do
      code "tar -xf #{Chef::Config[:file_cache_path]}/amplib.tgz -C #{node[:tomcat7][:install_path]}/lib"
    end

    service "tomcat" do
      action :start
    end

    tag("amp-deployed")
  end
rescue
  untag("amp-deployed")
end

template "#{node[:tomcat7][:install_path]}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner node[:tomcat7][:user]
  group node[:tomcat7][:group]
  mode "0755"
end

template "/etc/mongosd.conf" do
  source "mongosd.conf.erb"
  owner node[:mongodb][:user]
  group node[:mongodb][:group]
  notifies :restart, "service[mongosd]", :delayed
end

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "amp")

template "/etc/pgbouncer_userlist" do
  source "userlist.txt.erb"
  owner node[:postgresql][:user]
  group node[:postgresql][:group]
  variables({
              :pass => app_secrets["appuser"]
            })
  notifies :restart, "service[pgbouncer]", :delayed
end

dbconn = Hash.new
dbconn[:user] = app_secrets["db"]["user"]
dbconn[:pass] = app_secrets["db"]["pass"]
dbconn[:host] = node[:amp][:authdb][:host]
dbconn[:port] = node[:amp][:pgbouncer][:port]

template "/etc/pgbouncer.ini"do
  source "pgbouncer.ini.erb"
  owner node[:postgresql][:user]
  group node[:postgresql][:group]
  variables({
              :db => dbconn
            })
  notifies :restart, "service[pgbouncer]", :immediately
end

service "pgbouncer" do
  supports :stop => true, :start => true, :restart => true, :status => true
  action [:enable, :start]
end

service "mongosd" do
  supports :stop => true, :start => true, :restart => true, :status => true
  action [:enable, :start]
end

%w{ catalina.policy catalina.properties context.xml server.xml tomcat-users.xml web.xml }.each do |conf|
  template "#{node[:tomcat7][:install_path]}/conf/#{conf}" do
    source "#{conf}.erb"
    owner node[:tomcat7][:user]
    group node[:tomcat7][:group]
    variables({
                :db => dbconn
              })
  end
end

include_recipe "amp::xbox"

service "tomcat" do
  action [:enable, :start]
end
