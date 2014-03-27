name "base"
description "common role applied to all nodes"
all_env = [
           "recipe[resolver]",
           "recipe[yum]",
           "recipe[ntp]",
           "recipe[timezone]",
           "recipe[cron]",
           "recipe[chef-client]",
           "recipe[zsh]",
           "recipe[users::sysadmins]",
           "recipe[sudo]",
           "recipe[emacs]",
           "recipe[vim]",
           "recipe[git]",
           "recipe[build-essential]",
           "recipe[perl]",
           "recipe[python]",
           "recipe[screen]",
           "recipe[nscd]",
           "recipe[openssh]",
           "recipe[motd-tail]",
           "recipe[operations]",
           "recipe[logrotate::syslog]",
           "recipe[vmware-tools::noop]",
           "recipe[ulimit]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "stage" => all_env + ["role[monitored]"],
              "prod" => all_env + ["role[monitored]"],
              "ec2-prod" => all_env + ["role[monitored]"],
              "ec2" => all_env,
              "hls"=> all_env + ["role[monitored]"],
              "prod-OPS-6422-JH"=> all_env + ["role[monitored]"]
              )

default_attributes ({
                      "snmp" => {
                        "community" => "37cd175ce59c39f191"
                      },
                      "admin_email" => "ccd-sa@clearchannel.com"
                    })
