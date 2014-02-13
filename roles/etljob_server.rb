name "etljob_server"
description "ETL Job Server"
all_env = [
           "recipe[users::deployer]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "stage" => all_env + ["recipe[etl_jobs::event_job]", "recipe[fac::genre]"],
              "prod" => all_env + ["recipe[etl_jobs]"],
              "ec2-prod" => all_env + ["recipe[etl_jobs::ec2]"],
              "ec2" => all_env
              )
