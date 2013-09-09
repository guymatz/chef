


default[:elasticsearchnew][:version] = "0.90.3"
default[:elasticsearchnew][:url] = "http://files.ihrdev.com/elasticsearch"

default[:elasticsearchnew][:base_path] = "/data/apps"
default[:elasticsearchnew][:deploy_path] = "/data/apps/elasticsearch"
default[:elasticsearchnew][:ihrsearch_path] = "/data/apps/ihr-search"
default[:elasticsearchnew][:input_path] = "/data/apps/ihr-search/input"
default[:elasticsearchnew][:ihrsearch][:files] = "configs.tar.gz"
default[:elasticsearchnew][:user] = "elasticsearch"
default[:elasticsearchnew][:group] = "elasticsearch"

# elasticsearch.yml
default[:elasticsearchnew][:shards] = "3"
default[:elasticsearchnew][:replicas] = "1"
default[:elasticsearchnew][:mlockall] = true
default[:elasticsearchnew][:cluster_name] = ""

# ulimits
default[:elasticsearchnew][:ulimits] = [{
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
