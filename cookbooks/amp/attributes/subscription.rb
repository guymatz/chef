case chef_environment
when "prod"
  ### PROD ATTRIBUTES START ###
  ### PROD ATTRIBUTES END ###
else
  ### _DEFAULT ATTRIBUTES START ###
  default[:subscription][:port] = 8080
  default[:subscription][:requestlog_console_enabled] = false
  default[:subscription][:requestlog_file_enabled] = true
  default[:subscription][:requestlog_file_name] = "./logs/requests.log"
  default[:subscription][:requestlog_file_archive_name] = "./logs/requests-%d.log.gz"
  default[:subscription][:requestlog_file_count] = 14
  default[:subscription][:log_console_enabled] = false
  default[:subscription][:log_file_enabled] = true
  default[:subscription][:log_file_name] = "./logs/service.log"
  default[:subscription][:log_file_archive_name] = "./logs/service-%d.log.gz"
  default[:subscription][:log_file_count] = 14
  default[:subscription][:vindicia_host] = "https://soap.prodtest.sj.vindicia.com"
  default[:subscription][:vindicia_timeout] = "10s"
  default[:subscription][:vindicia_items_per_page] = 10
  default[:subscription][:mongo_host] = "127.0.0.1"
  default[:subscription][:mongo_port] = 27017
  default[:subscription][:mongo_auto_retry] = true
  default[:subscription][:mongo_retry_time] = 5000
  default[:subscription][:mongo_connections_per_host] = 50
  default[:subscription][:mongo_connection_timeout] = 5000
  default[:subscription][:mongo_socket_timeout] = 5000
  default[:subscription][:mongo_max_wait_time] = 5000
  default[:subscription][:mongo_write_concern] = 1 
  default[:subscription][:mongo_db_name] = "subscriptions"
  default[:subscription][:swagger_host] = 127.0.0.1
  default[:subscription][:swagger_file_path] = "/swagger-ui/"
  default[:subscription][:swagger_url_path] = "/docs"
  default[:subscription][:swagger_index_file] = "index.html"
  default[:subscription][:graphite_host] = "10.88.165.114"
  default[:subscription][:graphite_port] = 2003
  default[:subscription][:graphite_prefix] = "subscriptions.stage"
  default[:subscription][:graphite_interval] = "10s"
  default[:subscription][:path] = "/data/apps/subscription"
  ### _DEFAULT ATTRIBUTES END ###
end
