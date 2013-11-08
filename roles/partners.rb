name "partners"
description "sets up a partners.iheart.com server"
all_env = [
           "recipe[users::deployer]",
           "recipe[users::partners]",
           "recipe[partners.iheart.com]"
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

default_attributes ({
                    })
