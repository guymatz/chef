default[:sonos][:repo] = "git@github.com:iheartradio/sonos.git"
default[:sonos][:rev] = "683d98db3b5b47bb95907963a33fc081bd460ae1"
default[:sonos][:deploy_path] = "/data/apps/sonos"

case chef_environment
when /^prod/
  default[:sonos][:mysql_vip] = "iad-mysql-util-v260.ihr"
when /^ec2-prod/
  default[:sonos][:mysql_vip] = "use1b-sonos-vip-v150.ihr"
when /^stage/
  default[:sonos][:mysql_vip] = "iad-stg-sonos-vip-v760.ihr" 
when /^dev/
  default[:sonos][:mysql_vip] = "iad-stg-sonos-vip-v760.ihr"
end

case node[:platform_family]
when "centos"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel mysql-devel }
when "rhel"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel mysql-devel }
when "debian"
  default[:sonos][:packges] = %w{ }
end

