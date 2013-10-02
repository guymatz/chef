name "memcached"
description "memcached"
all_env = [
           "recipe[membase]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
