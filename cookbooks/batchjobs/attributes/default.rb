default[:batchjobs][:packages] = %w{ pymongo pyodbc amqp freetds python-suds python-psycopg2 }
default[:batchjobs][:pip_packages] = { "sqlcmd" => "0.7.1" }
default[:batchjobs][:repo] = "git@github.ihrint.com:Ingestion/BatchJobs.git"
default[:batchjobs][:rev] = "HEAD"
default[:batchjobs][:deploy_path] = "/data/apps/batchjobs"
default[:batchjobs][:secretpath] = "/etc/chef/encrypted_data_bag_secret"
default[:batchjobs][:user] = "batchjobs"
default[:batchjobs][:group] = "batchjobs"
