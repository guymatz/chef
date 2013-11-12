name "backup_util"
description "backup_util"
all_env = [
  "recipe[mongodb::backup_util]",
]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                    "backup_util" => {
                    },
                   })
override_attributes({
                    })
