name "mongodb_server"
description "mongodb_server"
all_env = [
  "recipe[mongodb]",
  "recipe[mongodb::server]",
  "recipe[mongodb::ulimits]",
  "recipe[users::deployer]",
  "recipe[mongodb::admin_scripts]",
  "recipe[diamond::mongo]",
]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                    "mongodb" => {
                    },
                    "nagios" => {
                      "server-type" => "dba-server"
                    },
                    "diamond" => {
                      "collectors" => {
                        "MongoDBCollector" => {
                          "host" => "localhost:37017"
                        }
                      }
                    }
                   })
override_attributes({
                    })
