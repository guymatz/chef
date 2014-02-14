# Deployment Settings
default[:webplayer][:repo] = "git@github.com:iheartradio/web.git"
default[:webplayer][:rev] = "release-5.2.1-fosters-emr1"
default[:webplayer][:deploy_path] = "/data/www/webplayer"
default[:webplayer][:geo_path] = "/data/www/webplayer/current/ihr/utils/data/geo"
default[:webplayer][:geo_file_name] = "GeoIPCity.dat"
# Number of days before pulling a new copy from files.ihrdev.com
default[:webplayer][:geo_freshness] = 60

default[:webplayer][:packages] = %w{ libxslt-devel python27-debuginfo python27-libs python27-tools python27-devel python27 python27-test }

default[:webplayer][:user] = "root"
case node[:platform]
when "debian"
  default[:webplayer][:group] = "nogroup"
when "centos"
  default[:webplayer][:group] = "nobody"
end

# ulimits
default[:webplayer][:ulimits] = [{
                                 "type" => "hard",
                                 "item" => "nproc",
                                 "value" => "4096"
                               },
                               {
                                 "type" => "soft",
                                 "item" => "nproc",
                                 "value" => "4096"
                               },
                               {
                                 "type" => "hard",
                                 "item" => "nofile",
                                 "value" => "65535"
                               },
                               {
                                 "type" => "soft",
                                 "item" => "nofile",
                                 "value" => "65535"
                               }]
