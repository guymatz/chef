#Default mongosd Configuration elements

default[:mongosd][:packages] = %w{mongo-10gen.x86_64 mongo-10gen-server.x86_64}

#/etc/init.d/mongod startup file elements
default[:mongosd][:user]                ='mongod'
default[:mongosd][:group]               ='mongod'
default[:mongosd][:pidfile_name]        ='mongosd.lock'
default[:mongosd][:pidfile_loc]         ='/data/db/mongos'
default[:mongosd][:lock_file]           ='/var/lock/subsys/mongosd'
default[:mongosd][:data_dir]            ='/data/db/mongos'

#mongod.conf config elements
default[:mongosd][:config_file_dir]     ='/etc/'
default[:mongosd][:config_file_name]    ='mongosd.conf'
default[:mongosd][:replset]             =''
default[:mongosd][:port]                =27017
default[:mongosd][:logpath]             ='/var/log/mongo/mongosd.log'
default[:mongosd][:logdir]              ='/var/log/mongo'
default[:mongosd][:rest]                ='true'
default[:mongosd][:journal]             ='true'
default[:mongosd][:configsvr]           ='false'
default[:mongosd][:arbiter]             ='false'
default[:mongosd][:configdbs]		='[]'
