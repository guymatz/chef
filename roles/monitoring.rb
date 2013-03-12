name "monitoring"
description "monitoring"
all_env = [
           "recipe[nagios::server]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "wa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "nagios" => {
                       "server_aliases" => "nagios-iad.ihrdev.com nagios-iad"
                     }
                   })
