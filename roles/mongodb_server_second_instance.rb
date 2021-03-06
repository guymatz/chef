name "mongodb_server_second_instance"
description "mongodb_server_second_instance"
all_env = [
  "recipe[mongodb]",
  "recipe[mongodb::server2]",
  "recipe[mongodb::ulimits]",
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
