name "batchjobs_code"
description "Batchjobs code deploy"
run_list(
         "recipe[users::deployer]",
         "recipe[users::batchjobs]",
         "recipe[batchjobs::code_deploy]"
)
