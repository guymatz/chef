name "mongodb_config_server"
description "mongodb_config_server"
all_env = [
	   "recipe[mongodb::cfgserver]",
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
                      }
                   })
override_attributes({
                    })
