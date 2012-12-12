name "bastion"
description "Secured SSH Bastion Server"
run_list(
         "recipe[users::sysadmins]",
         "recipe[sudo]",
         "role[monitored]",
         "recipe[openssh::bastion]",
         "recipe[iptables]",
         "recipe[ntp]",
         "recipe[selinux::permissive]",
         "recipe[chef-client]",
         "recipe[operations]",
         "recipe[timezone]",
         "recipe[zsh]"
         )
