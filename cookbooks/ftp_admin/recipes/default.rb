#
# Cookbook Name:: ftp_admin
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{ python27 python27-libs python27-devel python27-test python27-tools }.each do |p|
  package p
end

directory "/data/apps/ftp_admin/shared/venv" do
  recursive true
  owner node[:ftp_admin][:deployer]
#  group node[:ftp_admin][:group]
  action :create
end

python_virtualenv "/data/apps/ftp_admin/shared/venv" do
  interpreter "/usr/bin/python27"
  owner node[:ftp_admin][:deployer]
#  group node[:ftp_admin][:group]
  action :create   
end

bash "setup venv" do
      code <<-EOH
      chown -R #{node[:ftp_admin][:deployer]} #{node[:ftp_admin][:ftp_admin_path]}
      EOH
end

application "ftp_admin" do
  path "/data/apps/ftp_admin/"
  owner node[:ftp_admin][:deployer]
#  group node[:ftp_admin][:group]
  repository node[:ftp_admin][:repo]
  revision node[:ftp_admin][:rev]
  enable_submodules true
  before_restart do
    bash "setup venv" do
      code <<-EOH
      . /data/apps/ftp_admin/shared/venv/bin/activate && \
      pip install -r "/data/apps/ftp_admin/shared/cached-copy/requirements.txt"
      EOH
    end
  end
  gunicorn do
    app_module "ftp_admin:app"
    host "0.0.0.0"
    port 8080
    workers 9
    virtualenv "/data/apps/ftp_admin/shared/venv"
  end
end
