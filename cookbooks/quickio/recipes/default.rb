#
# Cookbook Name:: quickio
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#

res = search(:node, "chef_environment:#{node.chef_environment} AND roles:graphite")

debs = [
  "quickio_#{node['quickio']['version']}_amd64.deb",
  "quickio-ihr-nowplaying_#{node['quickio']['ihr_nowplaying_version']}_amd64.deb"
]

for d in debs do
  remote_file "#{Chef::Config[:file_cache_path]}/#{d}" do
    source node[:quickio][:ihr_files] + d
    mode "0644"
    action :create_if_missing
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
    :graphite_addr => res[0][:FQDN]
  })
end

service "quickio" do
  supports :start => true, :stop => true, :restart => true, :status => true
  action [:enable, :start]
end
