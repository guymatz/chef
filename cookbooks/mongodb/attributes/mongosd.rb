#Default mongosd Configuration elements

#/etc/init.d/mongosd startup file elements
default[:mongosd][:mongospidfile_name]        ='mongosd.pid'
default[:mongosd][:mongospidfile_loc]         ='/var/run/mongosd'
default[:mongosd][:mongoslock_file]           ='/var/lock/subsys/mongosd'
default[:mongosd][:mongosdata_dir]            ='/data/db/mongos'

#mongosd.conf config elements
default[:mongosd][:mongosconfig_file_dir]     ='/etc/'
default[:mongosd][:mongosconfig_file_name]    ='mongosd.conf'
default[:mongosd][:mongosreplset]             =''
default[:mongosd][:mongosport]                =27017
default[:mongosd][:mongoslogpath]             ='/var/log/mongo/mongosd.log'
default[:mongosd][:mongoslogdir]              ='/var/log/mongo'
default[:mongosd][:mongoslogappend]	      ='true'
default[:mongosd][:mongosrest]                ='true'
default[:mongosd][:mongosjournal]             ='false'
default[:mongosd][:mongosconfigsvr]           ='true'
default[:mongosd][:mongosarbiter]             ='false'
default[:mongosd][:mongosconfigdbs]		='[]'
