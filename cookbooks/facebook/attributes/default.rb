

default[:fbgraph][:deploy_path] = "/data/apps/fbgraph"
default[:fbgraph][:version] = "20130911"
default[:fbgraph][:url] = "http://files.ihrdev.com/fbgraph"

default[:fbtomcat][:version] = "2013-05-17_15-39-59"
default[:fbtomcat][:url] = "  "


# ulimits
default[:facebook][:ulimits] = [{
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
