default[:enrichment][:appdir] = "/data/apps/enrichment"
default[:enrichment][:log][:source] = "/data/log/enrichment-consumer/"
default[:enrichment][:log][:dest] = "iad-ss-nfs101-v600.ihr:/data/exports/files.ihrdev.com/Enrichment"
default[:enrichment][:log][:retention] = "14" # days
default[:enrichment][:log][:user] = "ihr-deployer"
default[:enrichment][:log][:sudo_user] = "amqp-consumer"
default[:playlog][:deploy_path] = "/data/jobs/playlog"
default[:playlog][:repo] = "git@github.com:iheartradio/playlog.git"
default[:playlog][:reference] = "0246f36d0c9c2a47d4fdd97942b0c4ebbb24b21d"
default[:db_sync_tools][:deploy_path] = "/data/jobs/db-sync-tools"
default[:db_sync_tools][:repo] = "git@github.com:iheartradio/amp-tools"
default[:db_sync_tools][:reference] = "d74b373c8b76f0a6994a1bb8427b045d891e7add"
default[:sysinfo][:version] = "1.0.0"
case chef_environment
when /^prod/
  default[:etl][:data_warehouse][:jdbc_url] = "jdbc:jtds:sqlserver://iad-dwh.prod.ihr:1433;databaseName=IHRDWH"
  default[:etl][:data_warehouse][:host] = "iad-dwh.prod.ihr"
  default[:etl][:data_warehouse][:port] = "1433"
  default[:etl][:data_warehouse][:batch_user_name] = "appBatch"
  default[:etl][:data_warehouse][:batch_user_password] = "i8piZZa4u"
  default[:etl][:event_job][:archive_directory] = "/isilon/event/processed"
  default[:etl][:event_job][:source_directory] = "/isilon/event"
  default[:etl][:event_job][:log_directory] = "/isilon/event/"
when /^stage/
  default[:etl][:data_warehouse][:jdbc_url] = "jdbc:jtds:sqlserver://10.5.50.101;databaseName=IHRDWH"
  default[:etl][:data_warehouse][:host] = "iad-dwh.prod.ihr"
  default[:etl][:data_warehouse][:port] = "1433"
  default[:etl][:data_warehouse][:batch_user_name] = "appBatch"
  default[:etl][:data_warehouse][:batch_user_password] = "i8piZZa4u"
  default[:etl][:event_job][:archive_directory] = "/data/log/event/processed"
  default[:etl][:event_job][:source_directory] = "/data/log/event/input"
  default[:etl][:event_job][:log_directory] = "/data/log/event"
else
  default[:etl][:data_warehouse][:jdbc_url] = "jdbc:jtds:sqlserver://iad-dwh.prod.ihr:1433;databaseName=IHRDWH"
  default[:etl][:data_warehouse][:batch_user_name] = "appBatch"
  default[:etl][:data_warehouse][:batch_user_password] = "i8piZZa4u"
  default[:etl][:event_job][:archive_directory] = "/isilon/event/processed"
  default[:etl][:event_job][:source_directory] = "/isilon/event/"
  default[:etl][:event_job][:log_directory] = "/isilon/event/"
end
