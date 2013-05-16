#
# Cookbook Name:: shared-web
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

#install some packages
%w{ tomcat7 apache2 }.each do |dep|
  include_recipe dep
end

node.set[:apache][:default_site_enabled] = false

%w{ ops.ihrdev.com files.ihrdev.com ipplan www.thumbplay.com }.each do |site|
  # we install the recipes and add it to the runlist so it is searchable
  include_recipe site
  unless node.run_list.include?("recipe[#{site}]")
    node.run_list << "recipe[#{site}]"
  end
end

file "#{node[:apache][:dir]}/sites-available/default" do
  action :delete
  only_if "test -f #{node[:apache][:dir]}/sites-available/default"
end

link "#{node[:apache][:dir]}/sites-available/default" do
  to "#{node[:apache][:dir]}/sites-available/#{node[:shared_web][:default_host]}.conf"
  notifies :reload, "service[apache2]"
  not_if "test -L #{node[:apache][:dir]}/sites-available/default"
end
