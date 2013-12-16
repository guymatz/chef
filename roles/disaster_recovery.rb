name "mongodb_server"
description "mongodb_server"
all_env = [
  "recipe[disaster_recovery]"
]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                   })
override_attributes({
                    })
