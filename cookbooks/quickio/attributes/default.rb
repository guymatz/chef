default[:quickio][:version] = '0.1.0'
default[:quickio][:cluster_version] = '0.1.0'
default[:quickio][:ihr_version] = '1.0.0'
default[:quickio][:libquickio_version] = '1.0.0'
default[:quickio][:ihr_files] = "http://files.ihrdev.com/Quick.IO/"

default[:quickio][:log_file] = "/var/log/quickio.log"
default[:quickio][:max_message_len] = 4096
default[:quickio][:max_subs] = 128
default[:quickio][:port] = 80
default[:quickio][:threads] = 12
default[:quickio][:user] = "quickio"

default[:quickio][:cluster][:is_server] = false
default[:quickio][:ihrnowplaying][:is_server] = false

default[:quickio][:apps] = [
	{
		"name" => "cluster",
		"path" => "cluster",
	},
	{
		"name" => "ihr-listening",
		"path" => "ihr-listening",
	},
]

if not node[:roles].include?('quickio-master')
	default[:quickio][:apps] << {
		"name" => "ihr-now-playing-client",
		"path" => "ihr-now-playing-client",
	}
else
	default[:quickio][:max_message_len] = 1048576
	default[:quickio][:threads] = 2

	default[:quickio][:cluster][:is_server] = true
	default[:quickio][:cluster][:balance_cooldown] = 120
	default[:quickio][:cluster][:balance_interval] = 120
	default[:quickio][:cluster][:balance_min_clients] = 5000
	default[:quickio][:cluster][:balance_threshold] = 20

	default[:quickio][:ihrnowplaying][:is_server] = true

	default[:quickio][:apps] << {
		"name" => "ihr-now-playing-server",
		"path" => "ihr-now-playing-server",
	}
end
