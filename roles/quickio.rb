name "quickio"
description "quickio"
all_env = [
           "recipe[users::quickio]"
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
