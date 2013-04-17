name "memcached"
description "memcached"
all_env = [
           "role[auto-bonded]",
           "recipe[couchbase::server]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
