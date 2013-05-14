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

git "/data/apps/www/customtalk" do
  repository "git@github.com:iheartradio/tool-talk.git"
  reference "custom_talk_deploy"
  notifies :run, 'bash[set_perms]', :immediately
end

# Enable WSGI Module
include_recipe "apache2"
include_recipe "apache2::mod_wsgi"

aliases = {'/customtalk/public/tp_shared' => '/data/aps/www/customtalk/tp_shared/public',
           '/customtalk/public' => '/data/apps/www/customtalk/public'}

pkgs = %w{ openldap-devel freetds unixODBC-devel }
pkgs.each do |p|
  package p
end

python_virtualenv "/data/apps/www/customtalk" do
  owner 'apache'
  group 'apache'
  action :create
end

pips = %w{ pyodbc lxml mako jinja2 pymongo python-ldap psycopg2 django }

pips.each do |p|
  python_pip p do
    virtualenv '/data/apps/www/customtalk'
    action :install
  end
end

web_app "customtalk" do
  cookbook 'custom_talk'
  server_name node['hostname']
  server_aliases [node['fqdn']]
  docroot "/data/apps/www/customtalk"
  app_alias aliases
  wsgi_daemon 'customtalk_prod user=apache threads=15 python-path=/data/apps/www/customtalk:/data/apps/www/customtalk/env/lib/python2.7/site-packages'
  wsgi_alias '/customtalk /data/apps/www/customtalk/customtalk.wsgi'
  wsgi_location '/customtalk'
  wsgi_proc 'customtalk_prod'
end

bash "set_perms" do
  code "chown -R apache. /data/apps/www/customtalk"
end
