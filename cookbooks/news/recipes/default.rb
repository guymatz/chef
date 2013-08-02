#
# Cookbook Name:: news
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ users::news }.each do |cb|
  include_recipe cb
end

%w{ python27 python27-libs python27-devel python27-test python27-tools }.each do |p|
  package p
end

directory "/data/apps/newsletter/shared/venv" do
  recursive true
  owner node[:news][:deployer]
  group node[:news][:group]
  action :create
end

python_virtualenv "/data/apps/newsletter/shared/venv" do
  interpreter "/usr/bin/python27"
  owner node[:news][:deployer]
  group node[:news][:group]
  action :create   
end

application "newsletter" do
  path "/data/apps/newsletter/"
  owner node[:news][:deployer]
  group node[:news][:group]
  repository node[:news][:repo]
  revision node[:news][:rev]
  before_restart do
    bash "setup venv" do
      code <<-EOH
      . /data/apps/newsletter/shared/venv/bin/activate && \
      pip install -r "/data/apps/newsletter/shared/cached-copy/requiments.txt"
      EOH
    end
  end
  gunicorn do
    app_module "dfp:app"
    host "0.0.0.0"
    port 8080
    workers 9
    virtualenv "/data/apps/newsletter/shared/venv"
  end
end

bash "setup venv" do
      code <<-EOH
      chown -R #{node[:news][:user]}. #{node[:news][:news_path]}
      EOH
end
