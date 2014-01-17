default[:batchjobs][:packages] = %w{ pymongo pyodbc amqp freetds python-suds }
default[:batchjobs][:pip_packages] = { "sqlcmd" => "0.7.1" }
default[:batchjobs][:repo] = "git@github.ihrint.com:Ingestion/BatchJobs.git"
default[:batchjobs][:rev] = "971b7a0976a6a8f281ef1de79b5966711027ba77"
default[:batchjobs][:deploy_path] = "/data/apps/batchjobs"
default[:batchjobs][:secretpath] = "/etc/chef/encrypted_data_bag_secret"
default[:batchjobs][:user] = "batchjobs"
default[:batchjobs][:group] = "batchjobs"
