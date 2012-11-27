# Install named on RHEL types
case node['platform']

# Install Bind9 on Redhat
  when "redhat","centos","scientific","arch","amazon"
    %w{ bind-chroot bind-utils perl-DBI libdbi-dbd-mysql }.each do |pkg|
    package pkg do
      action :install
    end
  end
end

# Add template for /etc/default/named
template "/etc/default/named" do
  source "named.erb"
  owner "named"
  group "named"
  mode "0644"
end

# Create directory #{node['bind-chroot']['chroot_dir']}
directory "/var/named/chroot" do
  owner "named"
  group "named"
  mode "0755"
  recursive true 
end

# Create directory #{node['bind-chroot']['zones_dir']}
directory "/var/named/chroot/zones" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/etc
directory "/var/named/chroot/etc" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/dev
directory "/var/named/chroot/dev" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var
directory "/var/named/chroot/var" do
  owner "named"
  group "named"
  mode "0755"
  action :create
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/cache
directory "/var/named/chroot/cache" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/cache/bind
directory "/var/named/chroot/var/cache/bind" do
  owner "named"
  group "named"
  mode "0755"
  recursive true
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/run
directory "/var/named/chroot/var/run" do
  owner "named"
  group "named"
  mode "0755"
end

# Create /var/named/chroot/var/run/named
directory "/var/named/chroot/var/run/named" do
  owner "named"
  group "named"
  mode "0755"
end

# Create /var/named/chroot/var/named
directory "/var/named/chroot/var/named" do
  owner "named"
  group "named"
  mode "0755"
end

# Create /var/named/chroot/var/named/internal
directory "/var/named/chroot/var/named/internal" do
  owner "named"
  group "named"
  mode "0755"
end


# Create directory #{node['bind-chroot']['chroot_dir']}/var/run/bind
directory "/var/named/chroot/var/run/bind" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/run/bind/run
directory "/var/named/chroot/var/run/bind/run" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory /staging_bind - for git sandbox
directory "/staging_bind" do
  owner "named"
  group "named"
  mode "0755"
end

# Create directory /usr/local/ipplan/bin - for export and update scripts
directory "/usr/local/ipplan" do
  owner "named"
  group "named"
  mode "0755"
end
directory "/usr/local/ipplan/bin" do
  owner "named"
  group "named"
  mode "0755"
end


# Add template for /var/named/chroot/named.conf.local
template "/var/named/chroot/etc/named.conf" do
  source "named.conf.local.erb"
  owner "named"
  group "named"
  mode "0644"
end

# Add template for /var/named/chroot/named.conf.options
template "/var/named/chroot/etc/named.options" do
  source "named.conf.options.erb"
  owner "named"
  group "named"
  mode "0644"
end

# copy in the rndckey file
template "/var/named/chroot/etc/rndc.key" do
  source "rndc.key.erb"
  owner "named"
  group "named"
  mode "0644"
end

# copy in the RFC1902 file
template "/var/named/chroot/etc/named.rfc1912.zones" do
  source "named.rfc1912.zones.erb"
  owner "named"
  group "named"
  mode "0644"
end

# copy in the localhost zone
template "/var/named/chroot/var/named/localhost.zone" do
  source "localhost.zone.erb"
  owner "named"
  group "named"
  mode "0644"
end

# copy in the localhost rev zone
template "/var/named/chroot/var/named/internal/0.0.127.in-addr.arpa.zone" do
  source "0.0.127.in-addr.arpa.zone.erb"
  owner "named"
  group "named"
  mode "0644"
end

# copy in the ipplan scripts
cookbook_file "/usr/local/ipplan/bin/ipplan-updatedns.sh" do
  source "ipplan-updatedns.sh"
  owner "named"
  group "named"
  mode "0755"
end

cookbook_file "/usr/local/ipplan/bin/update.conf" do
  source "update.conf"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "/usr/local/ipplan/bin/ipplan-updatefunc.sh" do
  source "ipplan-updatefunc.sh"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "/usr/local/ipplan/bin/ipplan-exportdns.pl" do
  source "ipplan-exportdns.pl"
  owner "root"
  group "root"
  mode "0700"
end

cookbook_file "/usr/local/ipplan/bin/sync_bind.sh" do
  source "sync_bind.sh"
  owner "root"
  group "named"
  mode "0750"
end

script "sync_zones_from_sandbox" do
  interpreter "bash"
  user "root"
  cwd "/staging_bind"
  code <<-EOH
  git pull
  /usr/local/ipplan/bin/sync_bind.sh
  EOH
end

service "named" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
