default[:quickio][:version] = '1.0.0'
default[:quickio][:cluster_version] = '1.0.0'
default[:quickio][:ihr_nowplaying_version] = '1.0.0'
default[:quickio][:ihr_files] = "http://files.ihrdev.com/Quick.IO/"

default[:quickio][:log_file] = "/var/log/quickio.log"
default[:quickio][:max_message_len] = 2048
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
		"name" => "nowplaying",
		"path" => "ihr-nowplaying",
	},
]
