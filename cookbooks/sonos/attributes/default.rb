default[:sonos][:repo] = "git@github.com:iheartradio/sonos.git"
default[:sonos][:rev] = "9f3d528fcf258c7452b974dce959c06c0214dfbf"
default[:sonos][:deploy_path] = "/data/apps/sonos"

case node[:platform_family]
when "rhel"
  default[:sonos][:packages] = %w{ python27 python27-devel python27-libs python27-debuginfo python27-tools libxslt-devel libxml2-devel }
when "debian"
  default[:sonos][:packges] = %w{ }
end

