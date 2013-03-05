
case node['platform']
when "ubuntu","debian"
  # Set CHROOT directory
  default['bind_chroot']['chroot_dir'] = "/var/bind9/chroot"
  # Set user name for BIND
  default['bind_chroot']['bind_user_name'] = "bind"
  # Set group name for BIND
  default['bind_chroot']['bind_group_name'] = "bind"
  # Store zones in OpenLDAP
  default['bind_chroot']['packages'] = %w{ bind9 bind9-doc bind9-host bind9utils dnsutils }
  default[:bind_chroot][:service] = "bind9"
  default[:bind_chroot][:name] = "bind"
when "redhat","centos","fedora","scientific","amazon"
  # Set CHROOT directory
  default[:bind_chroot][:chroot_dir] = "/var/named/chroot"
  # Set user name for BIND
  default[:bind_chroot][:bind_user_name] = "named"
  # Set group name for BIND
  default[:bind_chroot][:bind_group_name] = "named"
  default[:bind_chroot][:packages] = %w{ bind-chroot bind-utils perl-DBI libdbi-dbd-mysql }
  default[:bind_chroot][:service] = "named"
  default[:bind_chroot][:name] = "named"
end

# Store zones in OpenLDAP
default['bind_chroot']['store_zones_in_openldap'] = "no"
# Include zones.rfc1918
default['bind_chroot']['zones_rfc1928'] = "yes"
# Include openldap attributes file
include_attribute 'bind-chroot::openldap'

default[:bind_chroot][:staging] = "/var/named/chroot-stage"

default[:bind_chroot][:repo] = "git@github.com:iheartradio/ipplan-autogen.git"
