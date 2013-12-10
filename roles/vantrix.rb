name "vantrix"
description "Vantrix Encoder"
run_list(
  "recipe[users::deployer]",
  "role[encoders]",
  "recipe[users::splunk]",
  "recipe[encoders::vantrix]",
  "recipe[encoders::mixins]",
  "recipe[encoders::nagios]"
)
