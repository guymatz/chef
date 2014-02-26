name "social"
description "Social netowrk data gathering and ETL"
all_env = [
          "recipe[users::social]",
          "recipe[social]",
          "recipe[social::graph]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "prod" => all_env + ["recipe[social::tomcat]","recipe[social::log_cleanup]"],
              "ec2-prod" => all_env,
              "ec2" => all_env
              )

override_attributes({
})
