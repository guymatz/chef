name "monitoring-hls"
description "monitoring for hls"
all_env = [
  "recipe[nagios::server]",
  "recipe[nagios::pagerduty]",
  "recipe[java]",
  "recipe[riak-cs::nagios]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env,
              "hls" => all_env
              )
default_attributes({
                     "nagios" => {
                       "server_aliases" => "nagios-hls.ihrdev.com nagios-hls"
                     }
                   })
override_attributes({
                      "nagios" => {
                        "notifications_enabled" => "1"
                      },
                      "postfix" => {
                        "myhostname" => "nagios-hls",
                        "mydomain" => "iheart.com"
                      }
                    })
