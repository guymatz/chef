name "cnp"
description "CNP"
default_attributes "java" => {
  "jdk_version" => "7"
}
all_env = [
           "recipe[lucene]",
           "recipe[users::cnpuser]",
           "recipe[diamond]",
           "recipe[cnp]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "stage" => all_env,
              "prod" => all_env,
              "ec2-prod" => all_env,
              "ec2" => all_env
              )
