


default[:elasticsearch][:version] = "0.90.3"
default[:elasticsearch][:url] = "http://files.ihrdev.com/elasticsearch"

default[:elasticsearch][:base_path] = "/data/apps"
default[:elasticsearch][:deploy_path] = "/data/apps/elasticsearch"
default[:elasticsearch][:ihrsearch_path] = "/data/apps/ihr-search"
default[:elasticsearch][:input_path] = "/data/apps/ihr-search/input"
default[:elasticsearch][:ihrsearch][:files] = "configs.tar.gz"
default[:elasticsearch][:user] = "elasticsearch"
default[:elasticsearch][:group] = "elasticsearch"

# elasticsearch.yml
default[:elasticsearch][:shards] = "2"
default[:elasticsearch][:replicas] = "1"
default[:elasticsearch][:mlockall] = true
default[:elasticsearch][:cluster_membership] = ""

# ulimits
default[:elasticsearch][:ulimits] = [{
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
