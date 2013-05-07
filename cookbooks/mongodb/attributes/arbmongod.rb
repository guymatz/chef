#/etc/init.d/arbmongod startup file elements
default[:arbmongodb][:arbpidfile_name]        ='arbmongo.pid'
default[:arbmongodb][:arbpidfile_loc]         ='/var/run/arbmongo'
default[:arbmongodb][:arblock_file]           ='/var/lock/subsys/arbmongod'
default[:arbmongodb][:arbdata_dir]            ='/data/db/arbmongo'

#arbmongod.conf config elements
default[:arbmongodb][:arbconfig_file_dir]     ='/etc/'
default[:arbmongodb][:arbconfig_file_name]    ='arbmongod.conf'
default[:arbmongodb][:arbreplset]             =''
default[:arbmongodb][:arbport]                =47017
default[:arbmongodb][:arblogpath]             ='/var/log/mongo/arbmongod.log'
default[:arbmongodb][:arblogdir]              ='/var/log/mongo'
default[:arbmongodb][:arbrest]                ='true'
default[:arbmongodb][:arbjournal]             ='false'
default[:arbmongodb][:arbconfigsvr]           ='false'
default[:arbmongodb][:arbarbiter]             ='true'
