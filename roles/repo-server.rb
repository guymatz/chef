name "repo-server"
description "Yum, Gem, Pypy, Apt"
all_env = [
           "recipe[yumrepo]",
           "recipe[gems]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
              )
