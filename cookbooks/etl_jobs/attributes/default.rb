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
