#
# Cookbook Name:: bonded_interfaces
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

slaves = node['override']['bonded_interfaces']['configuration']['slaves']

slaves.each do |s|
	template "/etc/sysconfig/network-scripts/ifcfg-#{s}" do
		source "ifcfg-slave.erb"
		owner "root"
		group "root"
		mode "0644"
		variables({
			:device => s,
			:master => node['override']['bonded_interfaces']['master']
		})
		#notifies :run, resources(:execute => "ifdown #{s}")
		#notifies :run, resources(:execute => "ifup #{s}")
	end
end

template "/etc/sysconfig/network-scripts/ifcfg-#{node['override']['bonded_interfaces']['master']}" do
	source "ifcfg-bonded"
	mode 0644
	owner "root"
	group "root"
	variables({
                        :master => node['override']['bonded_interfaces']['master']
        })
	#notifies :run, resources(:execute => "ifdown #{node[:override][:bonded_interfaces][:master]}")
	#notifies :run, resources(:execute => "ifup #{node[:override][:bonded_interfaces][:master]}")
end

template "/etc/sysconfig/network-scripts/ifcfg-#{node['override']['bonded_interfaces']['master']}.#{node['override']['bonded_interfaces']['configuration']['vlan']}" do
	source "ifcfg-bonded_and_trunked.erb"
        owner "root"
        group "root"
        mode "0644"
        variables({
		:device => node['override']['bonded_interfaces']['master'],
     		:ip => node['override']['bonded_interfaces']['configuration']['ip'],
		:vlan => node['override']['bonded_interfaces']['configuration']['vlan'],
		:netmask => node['override']['bonded_interfaces']['configuration']['netmask']
	})
	#notifies :run, resources(:execute => "ifdown #{node[:bonded_interfaces][:master]}.#{node[:bonded_interfaces][:configuration][:vlan]}") 
	#notifies :run, resources(:execute => "ifup #{node[:bonded_interfaces][:master]}.#{node[:bonded_interfaces][:configuration][:vlan]}")
end
