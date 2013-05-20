default[:ganglia][:version] = "3.1.7"
default[:ganglia][:uri] = "http://sourceforge.net/projects/ganglia/files/ganglia%20monitoring%20core/3.1.7/ganglia-3.1.7.tar.gz/download"
default[:ganglia][:repo] = "git@github.com:iheartradio/monitor-core.git"
default[:ganglia][:checksum] = "bb1a4953"
default[:ganglia][:cluster_name] = "Production"
default[:ganglia][:unicast] = false
default[:ganglia][:server_role] = "ganglia-server"

default[:ganglia][:packages] = %w{ libtool }
default[:ganglia][:web_dir] = "/data/www/ganglia"
default[:ganglia][:python_mods] = "/usr/lib/ganglia/python_modules"
default[:ganglia][:conf_d] = "/etc/ganglia/conf.d"
default[:ganglia][:user] = "ganglia"
default[:ganglia][:group] = "ganglia"
