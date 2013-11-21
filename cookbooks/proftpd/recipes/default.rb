#
# Cookbook Name:: proftpd
# Recipe:: default
#
# Copyright 2009, Calogero Lo Leggio
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
#

include_recipe "users::vftp"
include_recipe "users::converter"

if node[:proftpd][:modules].include?('sql_mysql')
  package "proftpd-mod-mysql" do
    action :upgrade
  end
elsif node[:proftpd][:modules].include?('sql_postgres')
  package "proftpd-mod-pgsql" do
    action :upgrade
  end
else
  package "proftpd" do
    action :upgrade
  end
end

if node[:proftpd][:modules].include?('ldap')
  package "proftpd-mod-ldap" do
    action :upgrade
  end
end

service "proftpd" do
  supports :status => true, :restart => true, :reload => true
end

##@# cookbook_file "/etc/proftpd.conf" do
##@#   source "conf.ms"
##@# end

remote_directory "#{node[:proftpd][:dir]}/#{node[:proftpd][:dir_extra_conf]}" do
  source "conf.d"
  files_backup 0
  files_owner node[:proftpd][:ftp_user]
  files_group node[:proftpd][:ftp_group]
  files_mode 0600
  owner node[:proftpd][:ftp_user]
  group node[:proftpd][:ftp_group]
  mode 0700
end

directory "#{node[:proftpd][:dir]}/ssl" do
  owner node[:proftpd][:ftp_user]
  group node[:proftpd][:ftp_group]
  mode 0700
end

directory "#{node[:proftpd][:key_dir]}" do
  owner node[:proftpd][:ftp_user]
  group node[:proftpd][:ftp_group]
  mode 0700
end

template "#{node[:proftpd][:dir]}/modules.conf" do
  source "modules.conf.erb"
  mode 0644
  owner node[:proftpd][:ftp_user]
  group node[:proftpd][:ftp_group]
  notifies :restart, resources(:service => "proftpd")
end

## The original tempate that came with the cookbook
## Will go back to using this once I can figure out 
## how to get the correct IP from ohai!!
# template "#{node[:proftpd][:dir]}/proftpd.conf" do
template "/etc/proftpd.conf" do
   source "proftpd.conf.erb"
   mode 0644
   owner node[:proftpd][:ftp_user]
   group node[:proftpd][:group]
   notifies :restart, resources(:service => "proftpd")
end

if (node[:proftpd][:sql] == "on")
  template "#{node[:proftpd][:dir]}/#{node[:proftpd][:dir_extra_conf]}/sql.conf" do
    source "sql.conf.erb"
    mode 0644
    owner node[:proftpd][:user]
    group node[:proftpd][:group]
    notifies :restart, resources(:service => "proftpd")
  end
end

# Dir where ftp home dirs will be
directory "#{node[:proftpd][:default_root]}" do
  owner node[:proftpd][:ftp_user]
  group node[:proftpd][:ftp_group]
  mode 0750
end

# Dir where encoder will be mounted
# the converter user needs acccess to these . . .
directory "#{node[:proftpd][:encoder_mount_point]}" do
  owner node[:proftpd][:conv_user]
  group node[:proftpd][:conv_group]
  mode 0755
end

# mount encoder from isilon for processing by incron
mount node[:proftpd][:encoder_mount_point] do
  device node[:proftpd][:encoder_export]
  fstype "nfs"
  options "rw"
  action [:mount, :enable]
end

# And we need a link to /Utility for historical reasons
link "/Utility" do
  to "#{node[:proftpd][:default_root]}" 
end

service "proftpd" do
  action [ :enable, :start ]
end

include_recipe "proftpd::auth_file"
include_recipe "proftpd::sshkeys_files"

# I generally don't like to mix non-required packages into a cookbook
# like this, but I can't imagine an ftp server not requiring
# incron - gmatz
package "incron" do
  action :install
end
