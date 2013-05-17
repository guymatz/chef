name "backup_fac"
description "backup_fac"
all_env = [
  "recipe[mongodb::backup_fac]",
]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                    "backup_fac" => {
                    },
                   })
override_attributes({
                    })
