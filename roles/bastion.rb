name "bastion"
description "Secured SSH Bastion Server"
run_list(
         "recipe[users]",
         "recipe[sudo]",
         "role[monitored]",
         "recipe[openssh::iptables]",
         "recipe[iptables]",
         "recipe[ntp]",
         "recipe[selinux::permissive]",
         "recipe[chef-client]",
         "recipe[operations]",
         "recipe[timezone]",
         "recipe[zsh]"
         )
