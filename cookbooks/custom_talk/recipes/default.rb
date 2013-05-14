#
# Cookbook Name:: custom_talk
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "users::deployer"
#include_recipe "python::virtualenv"

git "/data/apps/www/custom_talk" do
  repository "git@github.com:iheartradio/tool-talk.git"
  reference "deploy_custom_talk"
end

# Enable WSGI Module
include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

aliases = {'/custom_talk/public/tp_shared' => '/data/aps/www/custom_talk/tp_shared/public',
           '/custom_talk/public' => '/data/apps/www/custom_talk/public'}

pkgs = %w{ openldap-devel freetds unixODBC-devel }
pkgs.each do |p|
  package p
end

python_virtualenv "/data/apps/www/custom_talk" do
  owner 'apache'
  group 'apache'
  action :create
end

pips = %w{ pyodbc lxml mako jinja2 pymongo python-ldap psycopg2 django }

#pips.each do |p|
#  python_pip p do
#    virtualenv '/data/apps/www/custom_talk'
#    action :install
#  end
#end

web_app "custom_talk" do
  cookbook 'custom_talk'
  server_name node['hostname']
  server_aliases [node['fqdn']]
  docroot "/data/apps/www/custom_talk"
  app_alias aliases
  wsgi_daemon 'customtalk_prod user=apache threads=15 python-path=/data/apps/www/custom_talk:/data/apps/www/custom_talk/env/lib/python2.7/site-packages'
  wsgi_alias '/custom_talk /data/apps/www/custom_talk/customtalk.wsgi'
  wsgi_location '/custom_talk'
  wsgi_proc 'customtalk_prod'
end

bash "set_perms" do
  code "chown -R apache. /data/apps/www/custom_talk"
end
