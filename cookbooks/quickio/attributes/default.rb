default[:quickio][:version] = '1.0.0'
default[:quickio][:ihr_nowplaying_version] = '1.0.0'
default[:quickio][:ihr_files] = "http://files.ihrdev.com/Quick.IO/"

default[:quickio][:cluster][:is_cluster_server] = false

default[:quickio][:log_file] = "/var/log/quickio.log"
default[:quickio][:max_message_len] = 2048
default[:quickio][:max_subs] = 128
default[:quickio][:threads] = 12
default[:quickio][:user] = "quickio"

default[:quickio][:apps] = [
	{
		"name" => "nowplaying",
		"path" => "ihr-nowplaying",
	},
]
