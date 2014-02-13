default[:enrichment][:appdir] = "/data/apps/enrichment"
default[:enrichment][:log][:source] = "/data/log/enrichment-consumer/"
default[:enrichment][:log][:dest] = "iad-ss-nfs101-v600.ihr:/data/exports/files.ihrdev.com/Enrichment"
default[:enrichment][:log][:retention] = "14" # days
default[:enrichment][:log][:user] = "ihr-deployer"
default[:enrichment][:log][:sudo_user] = "amqp-consumer"
default[:playlog][:deploy_path] = "/data/jobs/playlog"
default[:playlog][:repo] = "git@github.com:iheartradio/playlog.git"
default[:playlog][:reference] = "6bcb3a7ca546f243681bae1c01b3ebdd34f9f4b3"
default[:db_sync_tools][:deploy_path] = "/data/jobs/db-sync-tools"
default[:db_sync_tools][:repo] = "git@github.com:iheartradio/amp-tools"
default[:db_sync_tools][:reference] = "d74b373c8b76f0a6994a1bb8427b045d891e7add"
case chef_environment
when /^prod/
  default[:etl][:event_job][:archive_directory] = "/isilon/event/processed"
  default[:etl][:event_job][:source_directory] = "/isilon/event"
  default[:etl][:event_job][:log_directory] = "/isilon/event/"
when /^stage/
  default[:etl][:event_job][:archive_directory] = "/data/log/event/processed"
  default[:etl][:event_job][:source_directory] = "/data/log/event/input"
  default[:etl][:event_job][:log_directory] = "/data/log/event"
else
  default[:etl][:event_job][:archive_directory] = "/isilon/event/processed"
  default[:etl][:event_job][:source_directory] = "/isilon/event"
  default[:etl][:event_job][:log_directory] = "/isilon/event/"
end
