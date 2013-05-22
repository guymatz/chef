


default[:elasticsearch][:version] = "0.90.0"
default[:elasticsearch][:url] = "http://files.ihrdev.com/elasticsearch"

default[:elasticsearch][:base_path] = "/data/apps"
default[:elasticsearch][:deploy_path] = "/data/apps/elasticsearch"
default[:elasticsearch][:ihrsearch_path] = "/data/apps/ihr-search"
default[:elasticsearch][:ihrsearch][:files] = "configs.tar.gz"
default[:elasticsearch][:user] = "nobody"
default[:elasticsearch][:group] = "nobody"
