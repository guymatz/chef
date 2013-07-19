default[:sonos][:repo] = "git@github.com:iheartradio/sonos.git"
default[:sonos][:rev] = "983d691c89c68df4a9edb048c45d0124eb225ba3"
default[:sonos][:deploy_path] = "/data/apps/sonos"

case node[:platform_family]
when "rhel"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }
when "debian"
  default[:sonos][:packges] = %w{ }
end

