name "elasticsearch"
description "Elastic Search"
run_list(
         "recipe[elasticsearch]",
	 "recipe[elasticsearch::plugins]"
)
