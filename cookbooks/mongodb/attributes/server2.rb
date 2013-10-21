#/etc/init.d/mongod startup file elements
default[:mongodb2][:pidfile_name]	='mongod2.pid'
default[:mongodb2][:pidfile_loc]		='/var/run/mongod'
default[:mongodb2][:lock_file]		='/var/lock/subsys/mongod2'
default[:mongodb2][:data_dir]		='/data/db/mongo2'
default[:mongodb2][:startup_script_name] ='/etc/init.d/mongod2'

#mongod.conf config elements
default[:mongodb2][:config_file_dir]	='/etc/'
default[:mongodb2][:config_file_name]	='mongod2.conf'
default[:mongodb2][:replset]		=''
default[:mongodb2][:port]		=37018
default[:mongodb2][:logpath]		='/var/log/mongo/mongod2.log'
default[:mongodb2][:rest]		='true'
default[:mongodb2][:journal]		='true'
default[:mongodb2][:configsvr]		='false'
default[:mongodb2][:arbiter]		='false'
default[:mongodb2][:oplogsize]           ='23552'
