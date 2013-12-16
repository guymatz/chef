name "zookeeper"
description "Zookeeper"
run_list(
	 "recipe[users::zookeeper]",
         "recipe[zookeeper]"
)
