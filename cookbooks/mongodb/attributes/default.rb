#Default MongoDB Configuration elements

include_attribute 'mongodb::arbmongod'
include_attribute 'mongodb::mongosd'
include_attribute 'mongodb::cfgserver'


default[:mongodb][:packages] = %w{mongo-10gen mongo-10gen-server numactl}

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

default[:mongodb][:ulimits] = [ {
                                   "type" => "soft",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 },
                                 {
                                   "type" => "hard",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 }
                                ]


default[:mongodb][:source][:url] = "http://downloads.mongodb.org/linux/mongodb-linux-x86_64-"
default[:mongodb][:source][:version] = "2.0.2"
default[:mongodb][:source][:install_path] = "/usr/bin"
