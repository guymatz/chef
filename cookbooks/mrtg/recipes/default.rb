#
# Cookbook Name:: mrtg
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "mrtg" do
  action :install
end

directory "/etc/mrtg.d" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

execute "Generate MRTG index" do
  action :nothing
  command "indexmaker --perhost /etc/mrtg.cfg > /var/www/mrtg/index.html"
end

switches = []

search(:switches, "*:*") do |switch|
  execute "Configure MRTG for #{switch[:fqdn]}" do
    command "cfgmaker public@#{switch[:fqdn]} > /etc/mrtg.d/#{switch[:fqdn]}.conf"
    creates "/etc/mrtg.d/#{switch[:fqdn]}.conf"
    notifies :run, "execute[Generate MRTG index]"
  end
  switches << switch[:fqdn]
end

template "/etc/mrtg.cfg" do
  notifies :run, "execute[Generate MRTG index]"
  source "mrtg.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  variables :switches => switches.sort
end
