name "batchjobs_code"
description "Batchjobs code deploy"
run_list(
         "recipe[batchjobs::code_deploy]"
)
