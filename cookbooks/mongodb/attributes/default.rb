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
default[:mongodb][:data_device]		='/dev/sdb1'
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
