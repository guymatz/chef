#
# Cookbook Name:: bind_chroot
# Recipe:: default
#
node['bind_chroot']['packages'].each do |pkg|
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

directory "#{node['bind_chroot']['chroot_dir']}" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind_chroot']['chroot_dir']}/zones/internal" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind_chroot']['chroot_dir']}/etc" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind_chroot']['chroot_dir']}/dev" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind_chroot']['chroot_dir']}/var" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  action :create
end

directory "#{node['bind_chroot']['chroot_dir']}/cache" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
end

directory "#{node['bind_chroot']['chroot_dir']}/var/cache/bind" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind_chroot']['chroot_dir']}/var/run/named" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind_chroot']['chroot_dir']}/var/named/internal" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node['bind_chroot']['chroot_dir']}/var/run/bind/run" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

directory "#{node[:bind_chroot][:staging]}/var/named/internal" do
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0755"
  recursive true
end

results = search(:networks, "type:internal")
trusted_nets = Array.new
results.each do |r|
  trusted_nets << r
end
Chef::Log.info("Adding trusted networks to DNS ACLs: " + trusted_nets.join(" "))

results = search(:dns, "mode:forward")
fwd_zones = Array.new
results.each do |z|
  fwd_zones << z
end

results = search(:dns, "mode:reverse")
rev_zones = Array.new
results.each do |z|
  rev_zones << z
end

template "#{node['bind_chroot']['chroot_dir']}/etc/named.conf" do
  source "named.conf.local.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
  variables({
              :trusted_nets => trusted_nets,
              :dns_fwd_zones => fwd_zones,
              :dns_rev_zones => rev_zones,
              :zones_path => "internal"
            })
end

template "#{node['bind_chroot']['chroot_dir']}/etc/named.options" do
  source "named.conf.options.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

template "#{node['bind_chroot']['chroot_dir']}/etc/rndc.key" do
  source "rndc.key.erb"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind_chroot']['chroot_dir']}/etc/named.rfc1912.zones" do
  source "named.rfc1912.zones"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind_chroot']['chroot_dir']}/var/named/localhost.zone" do
  source "localhost.zone"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind_chroot']['chroot_dir']}/var/named/0.0.127.in-addr.arpa.zone" do
  source "0.0.127.in-addr.arpa.zone"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

cookbook_file "#{node['bind_chroot']['chroot_dir']}/var/named/named.root" do
  source "named.root"
  owner node['bind_chroot']['bind_user_name']
  group node['bind_chroot']['bind_group_name']
  mode "0644"
end

bash "export dns from ipplan" do
  user "root"
  cwd "/usr/local/bin/ipplan"
  code "/usr/local/bin/ipplan/bin/ipplan-updatedns.sh"
end

git_repo = "git@github.com:kplimack/ipplan-autogen.git"
git "/staging_bind" do
  repository git_repo
  revision "HEAD"
  reference "master"
  action :sync
  user "root"
  group "root"
end

bash "copy zone files from git to bind-chroot" do
  user "root"
  cwd "/staging_bind/"
  code <<-EOH
  cp -r /staging_bind/named/* /var/named/chroot/var/named/
EOH
end

service "named" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
