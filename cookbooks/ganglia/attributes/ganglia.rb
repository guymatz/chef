default[:ganglia][:version] = "3.6.0"
default[:ganglia][:uri] = "http://sourceforge.net/projects/ganglia/files/ganglia%20monitoring%20core/3.6.0/ganglia-3.6.0.tar.gz/download"
default[:ganglia][:repo] = "git@github.com:iheartradio/monitor-core.git"
default[:ganglia][:checksum] = "89eae02e1a11"
default[:ganglia][:cluster_name] = "Production"
default[:ganglia][:unicast] = false
default[:ganglia][:server_role] = "ganglia-server"

default[:ganglia][:packages] = %w{ libtool }
default[:ganglia][:web_dir] = "/data/www/ganglia"
default[:ganglia][:python_mods] = "/usr/lib64/ganglia/python_modules"
default[:ganglia][:conf_d] = "/etc/ganglia/conf.d"
default[:ganglia][:user] = "ganglia"
default[:ganglia][:group] = "ganglia"
