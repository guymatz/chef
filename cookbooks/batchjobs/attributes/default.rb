default[:batchjobs][:packages] = %w{ pymongo pyodbc amqp freetds python-suds python-psycopg2 }
default[:batchjobs][:pip_packages] = { "sqlcmd" => "0.7.1" , "celery" => nil }
default[:batchjobs][:repo] = "git@github.ihrint.com:Ingestion/BatchJobs.git"
default[:batchjobs][:rev] = "HEAD"
default[:batchjobs][:deploy_path] = "/data/apps/batchjobs"
default[:batchjobs][:secretpath] = "/etc/chef/encrypted_data_bag_secret"
default[:batchjobs][:user] = "batchjobs"
default[:batchjobs][:group] = "batchjobs"
case chef_environment
when /^prod/
default[:batchjobs][:rabbit_host] = "iad-rabbitmq-vip-v200.ihr"
default[:batchjobs][:rabbit_port] = 567
default[:batchjobs][:rovi_upload_identity] = "Prod"
default[:batchjobs][:mssql_db] = "iheartdw.ihrint.com"
when /^stage/
default[:batchjobs][:rabbit_host] = "iad-stg-rabbitmq-vip-v700.ihr"
default[:batchjobs][:rabbit_port] = 5673
default[:batchjobs][:rovi_upload_identity] = "Stage"
default[:batchjobs][:mssql_db] = "10.5.61.12"
when /^development/
default[:batchjobs][:rabbit_host] = "iad-int-rabbitmq101.ihr"
default[:batchjobs][:rabbit_port] = 5672
default[:batchjobs][:rovi_upload_identity] = "Dev"
default[:batchjobs][:mssql_db] = "10.5.61.12"
end
