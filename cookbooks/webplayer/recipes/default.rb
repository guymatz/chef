#
# Cookbook Name:: webplayer
# Recipe:: default
#
# Copyright 2013, iHeartRadio
# Jake Plimack <Jake.plimack@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

node[:webplayer][:packages].each do |p|
  package p
end

node.set[:apache][:binary]  = "/usr/sbin/httpd.worker"
node.save
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_status"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_log_config"
include_recipe "apache2::mod_proxy_http"
include_recipe "java"
include_recipe "users::webplayer"

node.set[:java][:oracle][:accept_oracle_download_terms] = true

# drop a github private deploy key for ops-auto
deploy_keys = Chef::EncryptedDataBagItem.load("keys", "webplayer-deploy")
file "/etc/chef/deploy" do
  owner "root"
  group "root"
  mode "0400"
  content deploy_keys['private_key']
  :create_if_missing
end

directory "/root/.ssh" do
  owner "root"
  group "root"
end

file "/root/.ssh/config" do
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
  Host github.com
    IdentityFile /etc/chef/deploy
    StrictHostKeyChecking no
EOH
end

directory "#{node[:webplayer][:deploy_path]}/logs" do
  owner node[:webplayer][:user]
  group node[:webplayer][:group]
  mode "0755"
end

link node[:supervisor][:log_dir] do
  to "#{node[:webplayer][:deploy_path]}/logs"
end

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "webplayers")

begin
  res = search(:node, "chef_environment:#{node.chef_environment} AND recipes:webplayer\\:\\:memcached")
rescue  Net::HTTPServerException
  Chef::Log.info("Could not search for memcached servers, bailing out!")
  exit
end

# data bucket = 11212
# session bucket 11213

memcached_servers = Array.new
res.each do |s|
  memcached_servers << s[:hostname] + "-v200.ihr:11212"
end

if not tagged?("webplayer-deployed")
  application "webplayer" do
    path node[:webplayer][:deploy_path]
    owner "root"
    group node[:webplayer][:group]
    repository node[:webplayer][:repo]
    revision node[:webplayer][:rev]
    migrate false
    action :deploy

    django do
      interpreter "python27"
      settings({
                 :secrets => app_secrets,
                 :url => node[:webplayer][:settings][:url],
                 :rpc => node[:webplayer][:settings][:rpc],
                 :statsd_conn => node[:webplayer][:settings][:statsd_conn],
                 :jinja => node[:webplayer][:settings][:jinja],
                 :memcached => memcached_servers
               })
      requirements "requirements.txt"
      debug true
      settings_template "settings.py.erb"
    end

    before_restart do
      bash "Webplayers: Build Static Resources" do
        user "root"
        cwd "#{node[:webplayer][:deploy_path]}"
        code <<-EOH
      source shared/env/bin/activate
      cd current
      python27 tusiq/config/local/manage.py assets build --settings=tusiq.config.prod2.settings
      EOH
      end
    end

    gunicorn do
      app_module :django
      command "tusiq.config.prod2.wsgi"
      worker_class "gevent"
      Chef::Log.info("Starting up Gunicorn on port 8080 for Basejump")
      port 8080
      autostart true
      workers 16
    end
  end

  tag("webplayer-deployed")
end

service "httpd-apache2" do
  case node[:platform_family]
  when "rhel"
    service_name "httpd"
  when "debian"
    service_name "apache2"
  end
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

template "#{node[:apache][:dir]}/sites-available/iheart.com" do
  owner "root"
  group "root"
  source "iheart.com.erb"
end

apache_site "iheart.com" do
  enable true
  notifies :reload, "service[httpd-apache2]"
end

template "/etc/security/limits.d/webplayer.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               :domain => "*",
               :ulimits => node[:webplayer][:ulimits]
             })
end

logrotate_app "webplayer" do
  cookbook "logrotate"
  path "/var/log/supervisor/*.log"
  options ["missingok", "delaycompress", "notifempty"]
  frequency "daily"
  enable true
  postrotate "find /var/log/supervisor -mtime +7 -exec rm -rf {} \;"
  create "0644 nobody root"
  rotate 7
end
