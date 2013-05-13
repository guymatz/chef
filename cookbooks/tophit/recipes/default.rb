#
# Cookbook Name:: tophit
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node[:tophit][:packages].each do |p|
  package p
end

directory "#{node[:tophit][:deploy_path]}" do
  owner "ihr-deployer"
  group "ihr-deployer"
  mode "0775"
  recursive true
end

python_virtualenv "#{node[:tophit][:deploy_path]}/shared/env" do
  interpreter "/usr/bin/python27"
  owner "ihr-deployer"
  group "ihr-deployer"
  options "--no-site-packages --distribute"
  action :create
end

deploy_revision "#{node[:tophit][:deploy_path]}" do
  repo node[:tophit][:repo]
  branch node[:tophit][:rev]
  migrate false
  user "ihr-deployer"
  group "ihr-deployer"
  enable_submodules false
  action :deploy
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear

  before_restart do
    bash "Install Pips into VirtualEnv" do
      user "ihr-deployer"
      cwd node[:tophit][:deploy_path]
      code <<-EOH
source shared/env/bin/activate
pip install -r current/tophit/requirements.txt
pip install -e current/tophit
EOH
    end
  end
end

file "/var/log/luigid.log" do
  owner "nobody"
  mode "0755"
end

directory "/var/run" do
  group "nobody"
  mode "0775"
end

template "/etc/init.d/luigid" do
  source "luigid.init.erb"
  owner "root"
  group "root"
  mode "0755"
end

service "luigid" do
  supports :start => true, :stop => true, :status => true
  action [:enable, :start]
end
