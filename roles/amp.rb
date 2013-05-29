name "amp"
description "Amp - API"
default_attributes "java" => {
  "jdk_version" => "7"
}
run_list(
         "role[auto-bonded]",
	 "role[mongosd]",
         "recipe[amp]",
         "recipe[pgbouncer]",
         "role[sendmail-smart-host]",
         "recipe[users::deployer]",
         "recipe[diamond]",
         "recipe[graphite::amp]"

)
