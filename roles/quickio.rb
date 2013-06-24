name "quickio"
description "quickio"
all_env = [
           "recipe[users::quickio]",
           "recipe[quickio]",
           "recipe[openssh::iptables]",
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
