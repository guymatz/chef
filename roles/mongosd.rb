name "mongosd"
description "mongosd"
all_env = [
           "recipe[mongodb::mongosd]",
           "recipe[mongodb::ulimits]",
           "recipe[mongodb::nagios]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "mongosd" => {
                       "mongosconfigdbs" => [
                                             "iad-mongo-usr101-v240.ihr:57017",
                                             "iad-mongo-usr103-v240.ihr:57017",
                                             "iad-mongo-usr105-v240.ihr:57017"
                                            ]
                     }
                   })
override_attributes({
                    })
