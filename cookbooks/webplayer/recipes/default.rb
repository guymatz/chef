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

include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_status"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_log_config"
include_recipe "apache2::mod_proxy_http"
include_recipe "java"

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

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "webplayers")

application "webplayer" do
  path node[:webplayer][:deploy_path]
  owner "root"
  group node[:webplayer][:group]
  repository node[:webplayer][:repo]
  revision node[:webplayer][:rev]
  migrate false
  action :deploy

  # Callbacks
  before_restart "tusiq/config/local/manage.py assets build --settings=tusiq.config.prod.settings"

  django do
    interpreter "python27"
    settings({
               :secrets => app_secrets,
               :url => node[:webplayer][:settings][:url],
               :rpc => node[:webplayer][:settings][:rpc],
               :statsd_conn => node[:webplayer][:settings][:statsd_conn],
               :jinja => node[:webplayer][:settings][:jinja]
             })
    requirements "requirements.txt"
    debug true
    settings_template "settings.py.erb"
  end

  gunicorn do
    app_module :django
    command "tusiq.config.prod.wsgi"
    worker_class "gevent"
    Chef::Log.info("Starting up Gunicorn on port 8080 for Basejump")
    port 8080
  end

end
