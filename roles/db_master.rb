name "db_master"
description "db master"
all_env = [
           "recipe[mysql]",
           "recipe[mysql::server]",
           "recipe[users::deployer]"

]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
