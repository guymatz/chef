#Default cfgmongodb Configuration elements

#/etc/init.d/mongod startup file elements
default[:cfgmongodb][:cfguser]		='mongod'
default[:cfgmongodb][:cfggroup]		='mongod'
default[:cfgmongodb][:cfgpidfile_name]	='cfgmongod.pid'
default[:cfgmongodb][:cfgpidfile_loc]		='/var/run/cfgmongo'
default[:cfgmongodb][:cfglock_file]		='/var/lock/subsys/cfgmongod'
default[:cfgmongodb][:cfgdata_dir]		='/data/db/cfgmongo'

#mongod.conf config elements
default[:cfgmongodb][:cfgconfig_file_dir]	='/etc/'
default[:cfgmongodb][:cfgconfig_file_name]	='cfgmongod.conf'
default[:cfgmongodb][:cfgreplset]		=''
default[:cfgmongodb][:cfgport]		=57017
default[:cfgmongodb][:cfglogpath]		='/var/log/mongo/cfgmongod.log'
default[:cfgmongodb][:cfglogdir]		='/var/log/mongo'
default[:cfgmongodb][:cfgrest]		='true'
default[:cfgmongodb][:cfgjournal]		='true'
default[:cfgmongodb][:cfgconfigsvr]		='true'
default[:cfgmongodb][:cfgarbiter]		='false'
