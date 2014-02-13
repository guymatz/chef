

default[:social_graph][:deploy_path] = "/data/apps/social_graph"
default[:social_graph][:version] = "1.0.5"
default[:social_graph][:url] = "http://files.ihrdev.com/jobs/social_graph"
default[:social_graph][:user] = "social_graph"
default[:social_graph][:group] = "social_graph"


default[:social_tomcat][:version] = "2013-05-17_15-39-59"
default[:social_tomcat][:url] = "http://files.ihrdev.com/Facebook-Tomcat"


# ulimits
default[:social][:ulimits] = [{
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
