name "monitoring"
description "monitoring"
all_env = [
  "recipe[nagios::server]",
  "recipe[nagios::pagerduty]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "nagios" => {
                       "server_aliases" => "nagios-iad.ihrdev.com nagios-iad"
                     }
                   })
override_attributes({
                      "nagios" => {
                        "notifications_enabled" => "1"
                      },
                      "postfix" => {
                        "myhostname" => "nagios-iad",
                        "mydomain" => "iheart.com"
                      }
                    })
