name "batchjobs"
description "Batch Jobs"
run_list(
         "recipe[users::deployer]",
         "recipe[users::batchjobs]",
         "recipe[users::int-sudo]",
         "recipe[batchjobs]"
)
