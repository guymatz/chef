name "flume-ng"
description "Flume-NG"
all_env = [
           "recipe[users::flume]",
           "recipe[flume-ng]",
           "recipe[flume-ng::nrpe]"
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
