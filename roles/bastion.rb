name "bastion"
description "Secured SSH Bastion Server"
run_list(
         "recipe[bastion]",
         "role[monitored]"
         )
