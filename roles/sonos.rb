name "sonos"
description "Sonos"
run_list(
         "recipe[users::deployer]",
         "recipe[sonos]",
	 "recipe[users::sonos-sudo]"
)
