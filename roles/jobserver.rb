name "jobserver"
description "Job Server: Cron, ETL, Etc."
all_env = [
           "recipe[cron]",
           "recipe[java]",
           "recipe[heartbeat]"
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
