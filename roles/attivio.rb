name "attivio"
description "Attivio Search"
all_env = [
           "recipe[attivio]"
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
