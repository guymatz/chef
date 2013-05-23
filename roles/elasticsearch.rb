name "elasticsearch"
description "Elastic Search"
run_list(
         "recipe[elasticsearch]",
         "role[ganglia-monitored]"
)
