#
# Cookbook Name:: bind-chroot
# Recipe:: chroot 
#
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Copyright 2012, Gerald L. Hevener Jr., M.S.
#

# References:
# http://bind9-ldap.bayour.com/
# http://arnauds-scrapbook.blogspot.com/2011/08/chroot-bind-in-debian-6-squeeze_1526.html

# Install Bind9 on Debian/Ubuntu
case node['platform']

  when "debian","ubuntu"
    %w{ bind9 bind9-doc bind9-host bind9utils dnsutils }.each do |pkg|
    package pkg do
      action :install
    end
  end

# Install Bind9 on Redhat
  when "redhat","centos","scientific","arch","amazon"
    %w{ bind-chroot bind-utils }.each do |pkg|
    package pkg do
      action :install
    end
  end
end

# Add template for /etc/default/bind9
template "/etc/default/bind9" do
  source "bind9.erb"
  owner "bind" 
  group "bind"
  mode "0644"
end

# Create directory #{node['bind-chroot']['chroot_dir']}
directory "/var/bind9/chroot" do
  owner "bind"
  group "bind"
  mode "0755"
  recursive true 
end

# Create directory #{node['bind-chroot']['zones_dir']}
directory "/var/bind9/chroot/zones" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/etc
directory "/var/bind9/chroot/etc" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/dev
directory "/var/bind9/chroot/dev" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var
directory "/var/bind9/chroot/var" do
  owner "bind"
  group "bind"
  mode "0755"
  action :create
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/cache
directory "/var/bind9/chroot/cache" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/cache/bind
directory "/var/bind9/chroot/var/cache/bind" do
  owner "bind"
  group "bind"
  mode "0755"
  recursive true
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/run
directory "/var/bind9/chroot/var/run" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create /var/bind9/chroot/var/run/named
directory "/var/bind9/chroot/var/run/named" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/run/bind
directory "/var/bind9/chroot/var/run/bind" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create directory #{node['bind-chroot']['chroot_dir']}/var/run/bind/run
directory "/var/bind9/chroot/var/run/bind/run" do
  owner "bind"
  group "bind"
  mode "0755"
end

# Create special device files
script "create_special_device_files" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  mknod /var/bind9/chroot/dev/null c 1 3
  mknod /var/bind9/chroot/dev/random c 1 8
  chmod 660 /var/bind9/chroot/dev/{null,random}
  EOH
  not_if "ls /var/bind9/chroot/dev/null |grep null"
end

# Move config dir to chroot jail
bash "mv_config_dir_to_chroot_jail" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  mv /etc/bind /var/bind9/chroot/etc
  EOH
  not_if "test -d /var/bind9/chroot/etc/bind"
end

# Create symbolic link to /etc/bind for compatibility
bash "create_symbolic_link_to_/etc/bind" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  ln -s /var/bind9/chroot/etc/bind /etc/bind
  EOH
  not_if "test -L /etc/bind"
end

# Edit PIDFILE var in /etc/init.d/bind9
bash "set_PIDFILE_environment_variable" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  echo -e >> /etc/profile
  echo "# Set PIDFILE environment variable" >> /etc/profile
  echo "export PIDFILE=/var/bind9/chroot/var/run/named/named.pid" >> /etc/profile
  . /etc/profile
  EOH
  not_if "cat /etc/profile |grep PIDFILE"
end

# Tell rsyslog where the bind logs are
bash "tell_rsyslog_about_bind_logs" do
  user "root"
  cwd "tmp"
  code <<-EOH
  echo "\$AddUnixListenSocket /var/bind9/chroot/dev/log" > /etc/rsyslog.d/bind-chroot.conf
  EOH
  not_if "cat /etc/rsyslog.d/bind-chroot.conf |grep chroot"
end

# Set permissions on jail
bash "set_permissions_on_chroot_jail" do
  user "root"
  cwd "tmp"
  code <<-EOH
  chown bind:bind -R /var/bind9/chroot
  EOH
  only_if "ls -al /var/bind9/chroot/var/ |grep root"
end

# Restart rsyslog & bind9
bash "restart_bind9_and_rsyslog" do
  user "root"
  cwd "tmp"
  code <<-EOH
  /etc/init.d/bind9 restart
  /etc/init.d/rsyslog restart
  /etc/init.d/slapd restart
  touch /var/bind9/chroot/restart.lock
  chown bind:bind /var/bind9/chroot/restart.lock
  EOH
  not_if "test -f /var/bind9/chroot/restart.lock"
end

# Add template for /var/bind9/chroot/named.conf.local
template "/var/bind9/chroot/named.conf.local" do
  source "named.conf.local.erb"
  owner "bind"
  group "bind"
  mode "0644"
end

# Add template for /var/bind9/chroot/named.conf.options
template "/var/bind9/chroot/named.conf.options" do
  source "named.conf.options.erb"
  owner "bind"
  group "bind"
  mode "0644"
end
