#
# Cookbook Name:: authorization
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "heartbeat"
include_recipe "authorization::sysctl"
include_recipe "authorization::ulimits"
include_recipe "php"

template "/etc/ha.d/ha.cf" do
	source "ha.cf.erb"
	mode 0644
	owner "root"
	group "root"
	variables({
		:current_node => node[:authorization][:current_node],
		:other_node => node[:authorization][:other_node]
	})
end

directory "/root/.ssh" do
  owner "root"
  group "root"
  mode 0700
  action :create
end

if node[:fqdn] =~ /iad-auth102.ihr/
 ifconfig "172.16.0.2" do
 	 bootproto "static"
 	 device "p2p2"
         mask "255.255.255.252"
 	 onboot "yes"
         action :enable
 end
 cookbook_file "/root/.ssh/id_rsa" do
	 source "node2_root/.ssh/id_rsa"
 	 mode 0600
	 owner "root"
	 group "root"
	 action :create_if_missing
 end
 cookbook_file "/root/.ssh/id_rsa.pub" do
         source "node2_root/.ssh/id_rsa.pub"
         mode 0644
         owner "root"
         group "root"
         action :create_if_missing
 end
end
if node[:fqdn] =~ /iad-auth101.ihr/
 ifconfig "172.16.0.1" do
         bootproto "static"
         device "p2p2"
         mask "255.255.255.252"
         onboot "yes"
         action :enable
 end
 cookbook_file "/root/.ssh/id_rsa" do
         source "node1_root/.ssh/id_rsa"
         mode 0600
         owner "root"
         group "root"
         action :create_if_missing
 end
 cookbook_file "/root/.ssh/id_rsa.pub" do
         source "node1_root/.ssh/id_rsa.pub"
         mode 0644
         owner "root"
         group "root"
         action :create_if_missing
 end
end

directory "/data" do
  owner "postgres"
  group "postgres"
  mode 0755
  action :create
end

cookbook_file "/etc/ha.d/README.config" do
        source "README.config"
        mode 0644
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/authkeys" do
        source "authkeys"
        mode 0600
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/harc" do
        source "harc"
        mode 0755
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/haresources" do
        source "haresources"
        mode 0644
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/postgres_monitor_daemon" do
        source "postgres_monitor_daemon"
        mode 0744
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/shellfuncs" do
        source "shellfuncs"
        mode 0644
        owner "root"
        group "root"
        action :create_if_missing
end

cookbook_file "/etc/ha.d/resource.d/datavol_carpathia" do
	source "resource.d/datavol_carpathia"
	owner "root"
	group "root"
	mode 0744
	action :create_if_missing
end

cookbook_file "/etc/ha.d/resource.d/postgres_monitor" do
        source "resource.d/postgres_monitor"
        owner "root"
        group "root"
        mode 0755
        action :create_if_missing
end

cookbook_file "/etc/ha.d/resource.d/stonith_drac" do
        source "resource.d/stonith_drac"
        owner "root"
        group "root"
        mode 0744
        action :create_if_missing
end
