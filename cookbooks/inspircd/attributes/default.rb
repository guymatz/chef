#
# Cookbook Name:: inspircd
# Attributes:: default

default['inspircd']['version']     = "2.0.8"
default['inspircd']['conf_dir']    = "/etc/inspircd"
default['inspircd']['log_dir']     = "/var/log/inspircd"
default['inspircd']['lib_dir']     = "/var/lib/inspircd"
default['inspircd']['bin_dir']     = "/usr/sbin"
default['inspircd']['modules_dir'] = "/var/lib/inspircd/modules"
default['inspircd']['binary']      = "/usr/sbin/inspircd"
default['inspircd']['pid']         = "/var/run/inspircd.pid"

default['inspircd']['listen']      = ['127.0.0.1']
default['inspircd']['fqdn']        = 'irc.tfoundry.com'

case node['platform']
when "debian","ubuntu"
  default['inspircd']['user']       = "irc"
  default['inspircd']['init_style'] = "runit"
when "redhat","centos","scientific","amazon","oracle","fedora"
  default['inspircd']['user']       = "irc"
  default['inspircd']['init_style'] = "init"
else
  default['inspircd']['user']       = "irc"
  default['inspircd']['init_style'] = "init"
end

set['inspircd']['version']   = "2.0.8"
set['inspircd']['prefix']    = "/opt/inspircd-#{node['inspircd']['version']}"
set['inspircd']['conf_path'] = "#{node['inspircd']['conf_dir']}/inspircd.conf"
set['inspircd']['default_configure_flags'] = [
  "--prefix=#{node['inspircd']['prefix']}",
  "--config-dir=#{node['inspircd']['conf_dir']}",
  "--module-dir=#{node['inspircd']['modules_dir']}",
  "--binary-dir=#{node['inspircd']['bin_dir']}",
  "--library-dir=#{node['inspircd']['lib_dir']}",
  "--enable-gnutls",
  "--enable-epoll"
]

