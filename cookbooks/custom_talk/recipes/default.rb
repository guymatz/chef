#
# Cookbook Name:: custom_talk
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "users::deployer"

git "/data/apps/www/custom_talk" do
  repository "git@github.com:iheartradio/tool-talk.git"
  reference "deploy_custom_talk"
  user "ihr-deployer"
  group "ihr-deployer"
end

# Enable WSGI Module
include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

aliases = {'/customtalk/public/tp_shared' => '/data/aps/www/customtalk/tp_shared/public',
           '/customtalk/public' => '/data/apps/www/customtalk/public'}

web_app "custom_talk" do
  server_name node['hostname']
  server_aliases [node['fqdn']]
  docroot "/data/apps/www/custom_talk"
  app_alias aliases
  wsgi_daemon 'customtalk_prod user=apache threads=15'
  wsgi_alias '/customtalk /data/apps/www/customtalk/customtalk.wsgi'
  wsgi_proc 'customtalk_prod'
end
