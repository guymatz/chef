name "loghost"
description "central syslogging server"
all_env = [
           "recipe[rsyslog::server]"
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
