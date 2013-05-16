#
# Cookbook Name:: roku.iheart.com
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "users::deployer"
include_recipe "apache2"
include_recipe "python::pip"

package 'python26-mod_wsgi' do
end

node[:roku][:pips].each do |pip|
    python_pip pip do
        action :install
    end
end

directory "/data/www/roku.iheart.com" do
  owner node[:apache][:user]
  group "ihr-deployer"
  mode 0770
  recursive true
end

git node[:roku][:path] do
  repository node[:roku][:repo]
  revision node[:roku][:revision]
  action :sync
end

web_app "roku.iheart.com" do
  server_name "proxy.iheart.com"
  server_aliases "roku.iheart.com"
  docroot node[:roku][:path]
end
