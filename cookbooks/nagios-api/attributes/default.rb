
default[:nagiosapi][:repo] = "git@github.com:xb95/nagios-api.git"
default[:nagiosapi][:rev] = "HEAD"

default[:nagiosapi][:path] = "/data/www/nagios-api"

default[:nagiosapi][:user] = "nobody"
case node[:platform_family]
when "rhel"
  default[:nagiosapi][:group] = "nobody"
when "debian"
  default[:nagiosapi][:group] = "nogroup"
end

default[:nagiosapi][:server][:name] = "nagios-api.ihrdev.com"
default[:nagiosapi][:server][:port] = "6315"
