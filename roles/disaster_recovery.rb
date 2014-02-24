name "disaster_recovery"
description "disaster_recovery"
all_env = [
  "recipe[nfs::server]",
  "recipe[disaster_recovery]",
  "recipe[avamar]",
  "recipe[disaster_recovery::nfs]",
  "recipe[disaster_recovery::unpack_attivio]",
  "recipe[disaster_recovery::unpack_auth]",
  "recipe[disaster_recovery::unpack_ing]",
  "recipe[disaster_recovery::unpack_mongo_fac]",
  "recipe[disaster_recovery::unpack_mongo_usr]",
  "recipe[disaster_recovery::unpack_mongo_util]"
]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                    "disaster_recovery" => {
                    },
                   })
override_attributes({
                    })
