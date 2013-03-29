#
# Author:: Jake Plimack <jake.plimack@gmail.com>
# Cookbook Name:: nagios
# Recipe:: nsca_source
#
include_recipe "build-essential"

# deps
%w{ libmcrypt-devel }.each do |p|
  package p
end

nsca_version = node['nagios']['nsca']['version']

remote_file "#{Chef::Config[:file_cache_path]}/nsca-#{nsca_version}.tar.gz" do
  source "#{node['nagios']['nsca']['url']}/nsca-#{nsca_version}/nsca-#{nsca_version}.tar.gz"
  checksum node['nagios']['nsca']['checksum']
  action :create_if_missing
end

bash "compile-nsca" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxvf nsca-#{nsca_version}.tar.gz
    cd nsca-#{nsca_version}
    ./configure --prefix=/usr \
                --sysconfdir=/etc \
                --localstatedir=/var \
                --libexecdir=#{node['nagios']['plugin_dir']}
    make all
    cp src/send_nsca #{node['nagios']['plugin_dir']}
  EOH
  not_if "test -f #{node['nagios']['plugin_dir']}/send_nsca"
end

