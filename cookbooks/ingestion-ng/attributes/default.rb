#Place where application will live

# github location
default[:ingestion_ng][:repo] = 'git@github.com:iheartradio/ingestion.git'
default[:ingestion_ng][:branch] = 'deploy'

# deploy path
default[:ingestion_ng][:deploy_path] = '/data/apps/ingestion-ng'
default[:ingestion_ng][:venv] = 'shared/venv'

default[:ingestion_ng][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools libxslt-devel libevent-devel nfs-utils }

default[:ingestion_ng][:user] = 'ihr-deployer'
default[:ingestion_ng][:group] = 'ihr-deployer'

default[:ingestion_ng][:apps] = [ 'ingqueue' ].join(',')

# default[:ingestion_ng][:init_style] = "heartbeat" # heartbeat or init

default[:ingestion_ng][:db_host] = 'localhost'
default[:ingestion_ng][:db_port] = 5432
default[:ingestion_ng][:db_user] = 'postgres'
default[:ingestion_ng][:db_password] = ''
default[:ingestion_ng][:db] = 'ingestion_ng'

default[:ingestion_ng][:celery_broker_host] = 'iad-qac1-rabbitmq101.ihr"
default[:ingestion_ng][:celery_pool] = 'gevent'
default[:ingestion_ng][:celery_concurrency] = 8
default[:ingestion_ng][:celery_result_backend] = 'amqp'
default[:ingestion_ng][:celery_cache_backend] = 'default'
default[:ingestion_ng][:celery_task_result_expire] = 3600
default[:ingestion_ng][:celery_imports] = 'ingqueue.tasks'

default[:ingestion_ng][:rabbit_user] = 'amp-tomcat'

# Apps write stuff here
default[:ingestion_ng][:var] = '/var/ingestion-ng'

# stage nfs mounts
default[:encoders][:stage_server] = "iad-stg-nfs101-v700.ihr"
default[:encoders][:s_ftp_export] = "/data//export/inbound-ftp"
default[:encoders][:s_ftp_mount] = "/data/inbound-ftp"
default[:encoders][:s_encoder_export] = "/data/export/encoder"
default[:encoders][:s_encoder_mount] = "/data/encoder"
