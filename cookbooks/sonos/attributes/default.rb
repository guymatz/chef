default[:sonos][:repo] = "git@github.com:iheartradio/sonos.git"
default[:sonos][:rev] = "381083d54aa4ddc3103ac15a67d7acbc64daadf1"
default[:sonos][:deploy_path] = "/data/apps/sonos"

case chef_environment
when /^prod/
  default[:sonos][:mysql_vip] = "10.5.36.62"
when /~stage/
  default[:sonos][:mysql_vip] = "10.5.53.30"
when /~dev/
  default[:sonos][:mysql_vip] = "10.5.53.30"
end

case node[:platform_family]
when "centos"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }
when "rhel"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }
when "debian"
  default[:sonos][:packges] = %w{ }
end

