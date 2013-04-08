default[:memcached][:memory]  = 4096
default[:memcached][:port]    = 11211
default[:memcached][:user]    = "nobody"
default[:memcached][:listen]  = "0.0.0.0"
default[:memcached][:maxconn] = "1024"

# These deps are for Nagios, Graphite, etc
default[:memcached][:monitoring][:packages] = %w{ perl-Time-HiRes perl-Cache-Memcached }
