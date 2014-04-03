#
# Cookbook Name:: pnp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.set[:java][:oracle][:accept_oracle_download_terms] = true
node.save
node.override[:java][:install_flavor] = oracle
node.override[:java][:jdk_version] = 7

include_recipe "users::pnp"
include_recipe "java"
include_recipe "users::deployer"

node[:pnp][:packages].each do |pkg| package pkg end

directory "#{node[:pnp][:pnp_path]}"
directory "#{node[:pnp][:log_path]}"

git "#{node[:pnp][:git_deploy_path]}" do
  repository "#{node[:pnp][:git_repo]}"
  action :sync
end

