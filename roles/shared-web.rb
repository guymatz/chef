name "shared-web"
description "Shared Web Server"
run_list(
         "role[auto-bonded]",
         "recipe[users::deployer]",
         "recipe[ops.ihrdev.com]",
         "recipe[files.ihrdev.com]",
         "recipe[ipplan::webserver]",
         "recipe[basejump]"
)
