name "hadoop"
description "Hadoop"
all_env = [
	   "role[sendmail-smart-host]",
       "recipe[users::hadoop]"

          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "prod" => all_env,
              "ec2-prod" => all_env,
              "ec2" => all_env
              )

override_attributes({
})
