name "monitoring"
description "monitoring"
all_env = [
           "recipe[nagios::server]",
           "recipe[bind-chroot]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "nagios" => {
                       "server_aliases" => "nagios-ec2.ihrdev.com nagios-ec2"
                     }
                   })
