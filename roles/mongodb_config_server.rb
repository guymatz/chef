name "mongodb"
description "mongodb"
all_env = [
           "recipe[mongodb]",
	   "recipe[mongodb::server]",
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
			"logpath" =>	"/var/log/mongo/mongocfg.log",
			"data_dir" =>	"/data/db/cfgmongo",
			"port" =>	"57017",
			"configsvr" =>	"true",
			"pidfile_loc" =>	"/data/db/cfgmongo",
			"pidfile_name" =>	"cfgmongod.lock",
			"config_file_name" =>	"cfgmongod.conf"
                      }
                   })
override_attributes({
                    })
