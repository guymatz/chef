name "vast"
description "Vast Proxy"
run_list(
         "role[auto-bonded]",
         "recipe[vast]"
)
