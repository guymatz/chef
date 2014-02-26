name "amp"
description "Amp - API"
default_attributes "java" => {
  "jdk_version" => "7"
}
all_env = [
           "role[mongosd]",
           "recipe[amp]",
           "recipe[pgbouncer]",
           "role[sendmail-smart-host]",
           "recipe[users::deployer]",
           "recipe[diamond]",
           "recipe[graphite::amp]"
          ]
run_list(all_env)

env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "dev" => all_env,
              "stage" => all_env + ["recipe[amp::newrelic]"],
              "prod" => all_env + ["role[auto-bonded]"],
              "ec2-prod" => all_env,
              "ec2" => all_env
              )
