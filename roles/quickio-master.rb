name "quickio-master"
description "quickio master server"
all_env = [
           "recipe[users::quickio]",
           "recipe[quickio::master]",
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
