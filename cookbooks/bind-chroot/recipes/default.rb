#
# Cookbook Name:: bind-chroot
# Recipe:: default
#


node[:bind-chroot][:packages].each do |pkg|
  package pkg do
    action :install
  end
end

# Add template for /etc/default/named
template "/etc/default/named" do
  source "named.erb"
  owner "named"
  group "named"
  mode "0644"
  variables({
              :chroot_dir => node['bind_chroot']['chroot_dir']
            })
end

directory "#{node['bind-chroot']['chroot_dir']}" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind-chroot']['chroot_dir']}/zones" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind-chroot']['chroot_dir']}/etc" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind-chroot']['chroot_dir']}/dev" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind-chroot']['chroot_dir']}/var" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  action :create
end

directory "#{node['bind-chroot']['chroot_dir']}/cache" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind-chroot']['chroot_dir']}/var/cache/bind" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind-chroot']['chroot_dir']}/var/run/named" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind-chroot']['chroot_dir']}/var/named/internal" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind-chroot']['chroot_dir']}/var/run/bind/run" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

template "#{node['bind-chroot']['chroot_dir']}/etc/named.conf" do
  source "named.conf.local.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

template "#{node['bind-chroot']['chroot_dir']}/etc/named.options" do
  source "named.conf.options.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

template "#{node['bind-chroot']['chroot_dir']}/etc/rndc.key" do
  source "rndc.key.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind-chroot']['chroot_dir']}/etc/named.rfc1912.zones" do
  source "named.rfc1912.zones"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind-chroot']['chroot_dir']}/var/named/localhost.zone" do
  source "localhost.zone"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node[:bind-chroot][:zone_path]}/internal/0.0.127.in-addr.arpa.zone" do
  source "0.0.127.in-addr.arpa.zone"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

service "named" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
