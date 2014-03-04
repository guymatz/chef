#Place where application will live

# github location
default[:ingestion_ng][:repo] = 'git@github.com:iheartradio/ingestion.git'
default[:ingestion_ng][:branch] = 'deploy'

# deploy path
default[:ingestion_ng][:deploy_path] = '/data/apps/ingestion-ng'
default[:ingestion_ng][:venv] = 'shared/venv'
default[:ingestion_ng][:var] = '/var/ingestion-ng'

default[:ingestion_ng][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools libxslt-devel libevent-devel nfs-utils postgresql-devel }

default[:ingestion_ng][:user] = 'ihr-deployer'
default[:ingestion_ng][:group] = 'ihr-deployer'

default[:ingestion_ng][:apps] = [ 'ingqueue' ].join(',')

# default[:ingestion_ng][:init_style] = "heartbeat" # heartbeat or init

default[:ingestion_ng][:db][:type] = 'mssql'
default[:ingestion_ng][:db][:driver] = 'pymssql'
default[:ingestion_ng][:db][:host] = 'ingestion_capr_dev'
default[:ingestion_ng][:db][:port] = 1433
default[:ingestion_ng][:db][:name] = 'Ingestion3'
default[:ingestion_ng][:db][:user] = 'adirnberger'
# FIXME move to a databag
default[:ingestion_ng][:db][:pass] = 'andypassword123'

default[:ingestion_ng][:celery][:broker_url] = 'amqp://%{user}:%{pass}@iad-stg-rabbitmq101.ihr/%{vhost}'
default[:ingestion_ng][:celery][:default_exchange] = 'ingestion'
default[:ingestion_ng][:celery][:task_serializer] = 'json'
default[:ingestion_ng][:celery][:accept_content] = 'json'
default[:ingestion_ng][:celery][:pool] = 'gevent'
default[:ingestion_ng][:celery][:concurrency] = 8
default[:ingestion_ng][:celery][:result_backend] = 'amqp'
default[:ingestion_ng][:celery][:result_exchange] = 'ingestion_results'
default[:ingestion_ng][:celery][:result_serializer] = 'json'
default[:ingestion_ng][:celery][:task_result_expires] = 3600
default[:ingestion_ng][:celery][:imports] = 'ingqueue.tasks'
default[:ingestion_ng][:rabbit][:user] = 'ingestion'
# FIXME move to a databag
default[:ingestion_ng][:rabbit][:pass] = 's3ym0ur'
default[:ingestion_ng][:rabbit][:vhost] = '/ingestion'

# stage nfs mounts
default[:encoders][:stage_server] = "iad-stg-nfs101-v700.ihr"
default[:encoders][:s_ftp_export] = "/data//export/inbound-ftp"
default[:encoders][:s_ftp_mount] = "/data/inbound-ftp"
default[:encoders][:s_encoder_export] = "/data/export/encoder"
default[:encoders][:s_encoder_mount] = "/data/encoder"

# FreeTDS
default[:freetds][:servers][default[:ingestion_ng][:db][:host]] = {
  :description => 'Ingestion msSQL',
  :host => 'iad-stg-dwh101.ihr',
  :port => 1433,
  :tds_version => '8.0',
  :client_charset => 'UTF-8'
}

# ODBC
default[:odbc][:name] = default[:ingestion_ng][:db][:host]
default[:odbc][:driver] = '/usr/lib64/libtdsodbc.so'
default[:odbc][:database] = default[:ingestion_ng][:db][:name]
default[:odbc][:description] = default[:freetds][:servers][default[:odbc][:name]][:description]
default[:odbc][:host] = default[:freetds][:servers][default[:odbc][:name]][:host]
default[:odbc][:client_charset] = default[:freetds][:servers][default[:odbc][:name]][:client_charset]
