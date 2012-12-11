name "webserver"
description "generic webserver"
all_env = [

]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
