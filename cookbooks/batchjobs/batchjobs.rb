name "batchjobs"
description "Batch Jobs"
all_env = [
         "recipe[users::deployer]",
         "recipe[users::batchjobs]",
         "recipe[batchjobs]"
	]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
	      "development" => all_env + ["recipe[users::int-sudo]"],
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )

default_attributes({
                   })
override_attributes({
                   })
