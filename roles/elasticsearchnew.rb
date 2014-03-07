name "elasticsearchnew"
description "Elastic Search New"
all_env = [
	 "recipe[java::oracle-7]",
         "recipe[elasticsearchnew]",
         "recipe[elasticsearchnew::plugins]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "prod" => all_env + ["recipe[elasticsearchnew::backup_client]"],
              "ec2-prod" => all_env,
              "ec2" => all_env
              )

override_attributes({
})
