default[:social_graph][:deploy_path] = "/data/apps/social_graph"
default[:social_graph][:version] = "1.0.8"
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
case chef_environment
when /^prod/
  default[:social][:ingestion][:host] = "iad-ing101-v260.ihr"
  default[:social][:ingestion][:port] = "5432"
  default[:social][:ingestion][:app_user_name] = "appbatchuser"
  default[:social][:ingestion][:password] = "Pq2Ajf82k9"
  default[:social][:social_graph][:log_directory] = "/var/log/fbgraph-consumer/"
when /^stage/
  default[:social][:ingestion][:host] = "iad-stg-ing101-v760.ihr"
  default[:social][:ingestion][:port] = "5432"
  default[:social][:ingestion][:app_user_name] = "appbatchuser"
  default[:social][:ingestion][:password] = "Pq2Ajf82k9"
  default[:social][:social_graph][:log_directory] = "/var/log/social_graph/"
else
  default[:social][:ingestion][:host] = "iad-ing101-v260.ihr"
  default[:social][:ingestion][:port] = ""
  default[:social][:ingestion][:app_user_name] = "appbatchuser"
  default[:social][:ingestion][:password] = "Pq2Ajf82k9"
  default[:social][:social_graph][:log_directory] = "/var/log/fbgraph-consumer/"
end
