# Deployment Settings
default[:webplayer][:repo] = "git@github.com:iheartradio/web.git"
default[:webplayer][:rev] = "release-4.11.1-zombie-uat1.2"
default[:webplayer][:deploy_path] = "/data/www/webplayer"

default[:webplayer][:packages] = %w{ libxslt-devel python27-debuginfo python27-libs python27-tools python27-devel python27 python27-test }

default[:webplayer][:user] = "nobody"
case node['platform']
when "debian"
  default[:webplayer][:group] = "nogroup"
when "centos"
  default[:webplayer][:group] = "nobody"
end

default[:webplayer][:settings][:statsd_conn][:host] = "statsd1.ihrdev.com"
default[:webplayer][:settings][:statsd_conn][:port] = "8125"

default[:webplayer][:settings][:rpc][:connection_timeout] = "7.5"
default[:webplayer][:settings][:rpc][:retry_timeout] = "12.0"
default[:webplayer][:settings][:rpc][:cache_prefix] = "rpc"
default[:webplayer][:settings][:rpc][:cache_enabled] = "True"

default[:webplayer][:settings][:url][:amp] = "http://api.sompa.iheart.com/api/v1/"
default[:webplayer][:settings][:url][:cms] = "http://api2.iheart.com/api/v1/"
default[:webplayer][:settings][:url][:image_scaler] = "http://img.iheart.com/"
default[:webplayer][:settings][:url][:image_scaler_new] = "http://imgproxy.iheart.com/"
default[:webplayer][:settings][:url][:ccrd_api_url] = "http://service.ccrd.clearchannel.com/"
default[:webplayer][:settings][:url][:amp] = "http://api.sompa.iheart.com/api/v1/"
default[:webplayer][:settings][:url][:amp_cdn] = "http://api2.iheart.com/api/v1/"
default[:webplayer][:settings][:url][:shorty] = "ihr.fm"
default[:webplayer][:settings][:url][:site_host] = "www.iheart.com"

default[:webplayer][:settings][:jinja][:cache_size] = "1000"
default[:webplayer][:settings][:jinja][:auto_reload] = "False"
default[:webplayer][:settings][:jinja][:bytecode_cache] = "None # MAGIC: look in common/settings"

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
