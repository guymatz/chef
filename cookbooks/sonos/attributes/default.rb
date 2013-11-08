default[:sonos][:repo] = "git@github.com:iheartradio/sonos.git"
default[:sonos][:rev] = "f4e32b8f0240fa7a5240d485d1ac6748e07dc7ac"
default[:sonos][:deploy_path] = "/data/apps/sonos"

case node[:platform_family]
when "rhel"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }
when "debian"
  default[:sonos][:packges] = %w{ }
end

