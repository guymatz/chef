#
# Cookbook Name:: bonded_interfaces
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_block "prod_ip" do
	block do
		prod_ip=resolv::dns("#{node['hostname']}.prod.ihr")
	end
end

cookbook_file "/etc/sysconfig/network-scripts/ifcfg-em2" do
	source "ifcfg-em2"
	owner "root"
	group "root"
	mode "0644"
end

cookbook_file "/etc/sysconfig/network-scripts/ifcfg-p2p1" do
        source "ifcfg-p2p1"
        owner "root"
        group "root"
        mode "0644"
end

cookbook_file "/etc/sysconfig/network-scripts/ifcfg-bond0" do
        source "ifcfg-bond0"
        owner "root"
        group "root"
        mode "0644"
end

template "/etc/sysconfig/network-scripts/ifcfg-bond0.200" do
	owner "root"
	group "root"
	mode "0644"
	source "ifcfg-bond0.200.erb"
	variables ({
		:ipaddress => prod_ip
		})
	notifies :restart, "service[network]"
end
