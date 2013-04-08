name "auto-bonded"
description "Autoconfigure bonded interfaces from DNS and monitor them"
all_env = [
           "recipe[bondage::dns]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "prod" => all_env,
              "ec2-prod" => all_env,
              "ec2" => all_env
              )
