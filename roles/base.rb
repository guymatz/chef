name "base"
description "common role applied to all nodes"
all_env = [
    "recipe[resolver]",
    "recipe[timezone]",
    "recipe[chef-client]",
    "recipe[zsh]",
    "recipe[users]",
    "recipe[sudo]",
    "recipe[emacs]",
    "recipe[vim]",
    "recipe[build-essential]",
    "recipe[cron]",
    "recipe[perl]",
    "recipe[python]",
    "recipe[screen]",
    "recipe[tmux]",
    "recipe[nscd]",
    "recipe[ntp]",
    "recipe[yum]",
    "recipe[openssh]",
    "recipe[motd-tail]",
    "recipe[nagios::client]",
    "recipe[operations]"
]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "ec2" => all_env
)
