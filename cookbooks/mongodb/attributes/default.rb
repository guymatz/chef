#Default MongoDB Configuration elements

default[:mongodb][:packages] = %w{mongo-10gen.x86_64 mongo-10gen-server.x86_64}

#/etc/init.d/mongod startup file elements
default[:mongodb][:user]		='mongod'
default[:mongodb][:group]		='mongod'
default[:mongodb][:pidfile_name]	='mongod.lock'
default[:mongodb][:pidfile_loc]		='/data/db/mongo'
default[:mongodb][:lock_file]		='/var/lock/subsys/mongod'
default[:mongodb][:data_dir]		='/data/db/mongo'
default[:mongodb][:data_device]		='/dev/sdb'
default[:mongodb][:data_mount_point]	='/data'

#mongod.conf config elements
default[:mongodb][:config_file_dir]	='/etc/'
default[:mongodb][:config_file_name]	='mongod.conf'
default[:mongodb][:replset]		=''
default[:mongodb][:port]		=37017
default[:mongodb][:logpath]		='/var/log/mongo/mongod.log'
default[:mongodb][:logdir]		='/var/log/mongo'
default[:mongodb][:rest]		='true'
default[:mongodb][:journal]		='true'
default[:mongodb][:configsvr]		='false'
default[:mongodb][:arbiter]		='false'
