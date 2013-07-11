# Deployment Settings
default[:webplayer][:repo] = "git@github.com:iheartradio/web.git"
default[:webplayer][:rev] = "release-4.13.0-baijiu-emr2"
default[:webplayer][:deploy_path] = "/data/www/webplayer"

default[:webplayer][:packages] = %w{ libxslt-devel python27-debuginfo python27-libs python27-tools python27-devel python27 python27-test }

default[:webplayer][:user] = "nobody"
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
