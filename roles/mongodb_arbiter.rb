name "mongodb"
description "mongodb"
all_env = [
           "recipe[mongodb]",
	   "recipe[mongodb::arbiter]",
           "recipe[mongodb::ulimits]",
	  ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "mongodb" => {
			"arbiter" =>	"true",
			"lock_file" =>	"/var/lock/subsys/arbmongod",
			"data_dir" =>	"/data/db/arbmongod",
			"pidfile_loc" =>	"/data/db/arbmongod",
			"pidfile_name"	=>	"arbmongod.lock",
			"config_file_name" =>	"arbmongod.conf",
			"logpath"	=>	"/var/log/arbmongo/mongod.log",
			"logdir"	=>	"/var/log/arbmongo",
			"journal"	=>	"false",
			"port" =>	"47017",
		     }
                   })
override_attributes({
                    })
