
default[:amp][:version] = "q-tip-rc5"
default[:amp][:url] = "http://files.ihrdev.com/amp"

default[:amp][:packages] = %w{ mongo-10gen-server mongo-10gen }

default[:amp][:authdb][:host] = "iad-auth101-v260.ihr"
default[:amp][:pgbouncer][:port] = "5432"

default[:amp][:logging][:script_path] = "/data/apps/amp/logging"
default[:amp][:logging][:log_path] = "/var/log/amp"

default[:amp][:logger][:url] = "http://files.ihrdev.com/amp/logger.war"

default[:amp][:logging][:user] = "nobody"
case node[:platform_family]
when "rhel"
  default[:amp][:logging][:group] = "nobody"
when "debian"
  default[:amp][:logging][:group] = "nogroup"
else
  default[:amp][:logging][:group] = "nobody"
end
