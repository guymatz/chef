name "attivio"
description "Attivio Search"
all_env = [
           "recipe[attivio]",
           "recipe[attivio::cleanup]"
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
override_attributes({
        "splunk" => {
            "forwarder_config_folder" => "prod",
            "forwarder_role" =>  "attivio"
          }
})
