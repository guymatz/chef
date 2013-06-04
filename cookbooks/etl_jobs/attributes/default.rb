


default[:enrichment][:appdir] = "/data/apps/enrichment"
default[:enrichment][:log][:source] = "/data/log/enrichment-consumer/enrichmentMisses.txt.*.tgz"
default[:enrichment][:log][:dest] = "iad-ss-nfs101-v600.ihr:/data/exports/files.ihrdev.com/Enrichment"
default[:enrichment][:log][:retention] = "14" # days
default[:enrichment][:log][:user] = "ihr-deployer"

