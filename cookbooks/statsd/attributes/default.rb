default["statsd"]["dir"]                          = "/usr/share/statsd"
default["statsd"]["conf_dir"]                     = "/etc/statsd"
default["statsd"]["repository"]                   = "git://github.com/etsy/statsd.git"
default["statsd"]["log_file"]                     = "/var/log/statsd.log"
default["statsd"]["flush_interval"]               = 10000
default["statsd"]["address"]                      = "0.0.0.0"
default["statsd"]["port"]                         = 8125
case chef_environment
when /^prod/
  default["statsd"]["graphite_host"]                = "iad-graphite101.ihr"
when /^stage/
  default["statsd"]["graphite_host"]                = "iad-stg-graphite101.ihr"
end
default["statsd"]["graphite_port"]                = 2003
default["statsd"]["graphite"]["legacy_namespace"] = true
