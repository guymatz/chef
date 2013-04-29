#Default cfgmongodb Configuration elements

default[:cfgmongodb][:packages] = %w{mongo-10gen.x86_64 mongo-10gen-server.x86_64}

#/etc/init.d/mongod startup file elements
default[:cfgmongodb][:user]		='mongod'
default[:cfgmongodb][:group]		='mongod'
default[:cfgmongodb][:pidfile_name]	='cfgmongod.lock'
default[:cfgmongodb][:pidfile_loc]		='/data/db/cfgmongo'
default[:cfgmongodb][:lock_file]		='/var/lock/subsys/cfgmongod'
default[:cfgmongodb][:data_dir]		='/data/db/cfgmongo'

#mongod.conf config elements
default[:cfgmongodb][:config_file_dir]	='/etc/'
default[:cfgmongodb][:config_file_name]	='cfgmongod.conf'
default[:cfgmongodb][:replset]		=''
default[:cfgmongodb][:port]		=57017
default[:cfgmongodb][:logpath]		='/var/log/mongo/cfgmongod.log'
default[:cfgmongodb][:logdir]		='/var/log/mongo'
default[:cfgmongodb][:rest]		='true'
default[:cfgmongodb][:journal]		='true'
default[:cfgmongodb][:configsvr]		='true'
default[:cfgmongodb][:arbiter]		='false'
