name "dns-server"
description "dns-master, ipplan"
all_env = [
           "recipe[bind-chroot]"
          ]
env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
              )

