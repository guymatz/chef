name "news"
description "News"
run_list(
         "recipe[users::deployer]",
         "recipe[news]"
)
