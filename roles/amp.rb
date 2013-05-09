name "amp"
description "Amp - API"
run_list(
         "role[auto-bonded]",
         "recipe[amp]",
         "recipe[pgbouncer]",
         "role[sendmail-smart-host]",
         "recipe[users::deployer]",
         "recipe[diamond]",
         "recipe[graphite::amp]"

)
