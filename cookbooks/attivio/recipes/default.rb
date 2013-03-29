#
# Cookbook Name:: attivio
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

include_recipe "attivio::users"
include_recipe "attivio::ulimits"

node[:attivio][:packages].each do |p|
  package p
end

directory node[:attivio][:install_path] do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  recursive true
end

git node[:attivio][:install_path] do
  repository node[:attivio][:repo]
  revision  node[:attivio][:rev]
  user node[:attivio][:user]
  group node[:attivio][:group]
  action :sync
  not_if "test -d #{node[:attivio][:install_path]}/.git"
end

remote_file "/tmp/AIE-installer.sh.gz" do
  source "http://yum.ihr/files/AIE_lin64_3.1.3.56386.sh.gz"
  action :create_if_missing
  owner "root"
  group "root"
end

script "unpack attivio installer" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
/bin/gzip -d AIE-installer.sh.gz
/bin/chmod +x AIE-installer.sh
EOH
  not_if "test -f /tmp/AIE-installer.sh"
end

template "/tmp/AIE-installer.exp" do
  source "attivio.exp.erb"
  owner "root"
  group "root"
  mode "0700"
  variables ({
               :aie_install_path => node[:attivio][:aie_install_path]
             })
end

directory node[:attivio][:aie_install_path] do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  recursive true
end

script "run attivio installer via Expect" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
/bin/rm -rf #{node[:attivio][:aie_install_path]}
/bin/chmod +x /tmp/AIE-installer.sh
/usr/bin/expect /tmp/AIE-installer.exp
EOH
  not_if "test -d #{node[:attivio][:aie_install_path]}/conf"
end

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "attivio")
cluster = search(:node, "recipes:attivio\\:\\:clustered AND chef_environment:#{node.chef_environment}")
master = search(:node, "recipes:attivio\\:\\:clustermaster AND chef_environment:#{node.chef_environment}")

# searcher = cluster - master
searchers = cluster
unless (defined?(master[0]["fqdn"])).nil?
  searchers.each_with_index do |s, index|
    if master[0]["fqdn"] == s["fqdn"]
      searchers.delete_at(index)
    end
  end
end


template "#{node[:attivio][:config_path]}/iheartradio-#{node.chef_environment}.xml" do
  source "iheartradio-env.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node.chef_environment,
              :search_config => node[:attivio][:search_config],
              :attivio_conf => node[:attivio][:config_path],
              :cluster => searchers
            })
end

template "#{node[:attivio][:config_path]}/iheartradio.xml" do
  source "iheartradio.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node.chef_environment
            })
end

template "#{node[:attivio][:config_path]}/iheartradio.#{node.chef_environment}.properties" do
  source "iheartradio.env.properties.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node.chef_environment,
              :install_path => node[:attivio][:install_path],
              :connector_port => node[:attivio][:connector_port],
              :indexer_port => node[:attivio][:indexer_port],
              :searcher_port => node[:attivio][:searcher_port],
              :dbconns => app_secrets["#{node.chef_environment}"],
              :directory => node[:attivio][:directory],
              :xml => node[:attivio][:xml],
              :cluster => searchers,
              :master => master[0]
            })
end

template "#{node[:attivio][:config_path]}/topology-nodes-#{node.chef_environment}.xml" do
  source "topology-nodes-env.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :connector_port => node[:attivio][:connector_port],
              :indexer_port => node[:attivio][:indexer_port],
              :searcher_port => node[:attivio][:searcher_port],
              :cluster => cluster,
              :master => master[0]
            })
end

directory "#{node[:attivio][:bin_path]}/#{node.chef_environment}" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
end

fqdns = Array.new
if (defined?(master[0]["fqdn"]))
  fqdns << master[0]["fqdn"]
end
cluster.each do |c|
  fqdns << c["fqdn"]
end

template "#{node[:attivio][:bin_path]}/#{node.chef_environment}/env.sh" do
  source "env.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_home => node[:attivio][:aie_install_path],
              :attivio_project => node[:attivio][:install_path],
              :zookeeper => fqdns,
            })
end

file "#{node[:attivio][:aie_install_path]}/conf/attivio.license" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  content app_secrets["license"]
  only_if "test -d #{node[:attivio][:aie_install_path]}/conf/"
end

