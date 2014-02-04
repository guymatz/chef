#
# Cookbook Name:: amp
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

#hostsfile_entry '10.5.36.28' do
#  hostname 'files.ihrdev.com'
#  #action :create_if_missing
#end

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
%w{ users::amp java tomcat7 amp::logging }.each do |r|
  include_recipe r
end

if node.chef_environment == "prod" or node.chef_environment == "ec2-prod"
  include_recipe "amp::nagios"
end

remote_file "#{node[:java][:java_home]}/jre/lib/security/US_export_policy.jar" do
  source "#{node[:amp][:url]}/jce/US_export_policy.jar"
  checksum "b800fef6edc0"
  mode "0755"
end

remote_file "#{node[:java][:java_home]}/jre/lib/security/local_policy.jar" do
  source "#{node[:amp][:url]}/jce/local_policy.jar"
  checksum "4a5c8f64107c"
  mode "0755"
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
      code <<-EOH
      rm -rf #{node[:tomcat7][:webapp_dir]}/api
      rm -rf #{node[:tomcat7][:install_path]}/work/*
      rm -rf #{node[:tomcat7][:install_path]}/temp/*
      rm -rf #{node[:tomcat7][:webapp_dir]}/ROOT/*
      EOH
      user "root"
    end

    remote_file "#{node[:tomcat7][:webapp_dir]}/ROOT/crossdomain.xml" do
      source "#{node[:amp][:url]}/crossdomain.xml"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end

    # JPD OPS-6114
    remote_file "#{node[:tomcat7][:webapp_dir]}/ROOT/akamai-endpoint.20Kb" do
      source "#{node[:amp][:url]}/akamai-endpoint.20Kb"
      owner node[:tomcat7][:user]
      group node[:tomcat7][:group]
      mode "0755"
    end


    remote_file "#{node[:tomcat7][:webapp_dir]}/api.war" do
      source "#{node[:amp][:url]}/#{node[:amp][:version]}/amp-rest-#{node[:amp][:amp_rest_version]}.war"
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
      checksum "e3b0c44298fc"
    end

    bash "Extract AMP Libs" do
      code "tar -xf #{Chef::Config[:file_cache_path]}/amplib.tgz -C #{node[:tomcat7][:install_path]}/lib"
    end

#    service "tomcat" do
#      action :start
#    end
    bash "Start Tomcat" do
      code "/etc/init.d/tomcat start"
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
  variables({
              :tomcat_dir => node[:tomcat7][:install_path]
            })
end

#template "/etc/mongosd.conf" do
#  source "mongosd.conf.erb"
#  owner node[:mongodb][:user]
#  group node[:mongodb][:group]
#  notifies :restart, "service[mongosd]", :delayed
#end

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

#service "mongosd" do
#  supports :stop => true, :start => true, :restart => true, :status => true
#  action [:enable, :start]
#end

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
