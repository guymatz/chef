name "mongosd"
description "mongosd"
all_env = [
           "recipe[mongodb]",
           "recipe[mongodb::ulimits]",
	   "recipe[mongodb::mongosd]",
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
			"pidfile_name" =>	"mongosd.lock",
			"lock_file" =>	"/var/lock/subsys/mongosd",
			"port" =>	"27017",
			"logpath"=>	"/var/log/mongo/mongosd.log",
			"config_file_name" =>	"mongosd.conf",
			"configdbs" =>	"[]",
                      }
                   })
override_attributes({
                    })
