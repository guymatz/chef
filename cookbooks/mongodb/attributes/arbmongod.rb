default[:mongodb][:packages] = %w{mongo-10gen.x86_64 mongo-10gen-server.x86_64}

#/etc/init.d/arbmongod startup file elements
default[:arbmongodb][:arbuser]                ='mongod'
default[:arbmongodb][:arbgroup]               ='mongod'
default[:arbmongodb][:arbpidfile_name]        ='arbmongod.lock'
default[:arbmongodb][:arbpidfile_loc]         ='/data/db/arbmongo'
default[:arbmongodb][:arblock_file]           ='/var/lock/subsys/arbmongod'
default[:arbmongodb][:arbdata_dir]            ='/data/db/arbmongo'

mongod.conf config elements
default[:arbmongodb][:arbconfig_file_dir]     ='/etc/'
default[:arbmongodb][:arbconfig_file_name]    ='arbmongod.conf'
default[:arbmongodb][:arbreplset]             =''
default[:arbmongodb][:arbport]                =47017
default[:arbmongodb][:arblogpath]             ='/var/log/mongo/arbmongod.log'
default[:arbmongodb][:arblogdir]              ='/var/log/mongo'
default[:arbmongodb][:arbrest]                ='true'
default[:arbmongodb][:arbjournal]             ='true'
default[:arbmongodb][:arbconfigsvr]           ='false'
default[:arbmongodb][:arbarbiter]             ='true'
