#
# Cookbook Name:: quickio
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#

is_master = node[:roles].include?('quickio-master')

if node.chef_environment == 'prod' and not is_master
  include_recipe "iptables"
  iptables_rule "port_quickio"
end

node[:fqdn] =~ /iad-([a-z0-9-]+)(\.ihr)?/i
hostname = $1 + ".iheart.com"

graphite = search(:node, "chef_environment:#{node.chef_environment} AND role:graphite")
qio_master = search(:node, "chef_environment:#{node.chef_environment} AND role:quickio-master")

debs = [
  "quickio_#{node['quickio']['version']}_amd64.deb",
  "quickio-app-cluster_#{node['quickio']['cluster_version']}_amd64.deb",
  "quickio-app-ihr_#{node['quickio']['ihr_version']}_amd64.deb",
  "libquickio-1.0_#{node['quickio']['libquickio_version']}_amd64.deb",
]

if not tagged?("quickio-deployed")
  for d in debs do
    remote_file "#{Chef::Config[:file_cache_path]}/#{d}" do
      source node[:quickio][:ihr_files] + d
      mode "0644"
    end

    dpkg_package d do
      ignore_failure true
      source "#{Chef::Config[:file_cache_path]}/#{d}"
      action :install
    end
  end

  execute "fix-dpkg-deps" do
    command "apt-get -yf install"
    action :run
  end

  template "/etc/quickio/quickio.ini" do
    owner "root"
    group "root"
    source "quickio.ini.erb"

    variables({
      :graphite_addr => graphite.nil? ? "" : graphite[0][:fqdn],
    })
  end

  if not is_master
    template "/etc/quickio/apps/ihr-now-playing-client.ini" do
      owner "root"
      group "root"
      source "ihr-now-playing-client.ini.erb"

      variables({
        :master_addr => qio_master[0][:fqdn],
      })
    end
  end

  template "/etc/quickio/apps/cluster.ini" do
    owner "root"
    group "root"
    source "cluster.ini.erb"

    variables({
      :master_addr => qio_master[0][:fqdn],
      :public_addr => hostname
    })
  end

  service "quickio" do
    supports :start => true, :stop => true, :restart => true, :status => true
    action [:enable, :restart]
  end

  tag("quickio-deployed")
end
