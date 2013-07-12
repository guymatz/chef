name "shared-web"
description "Shared Web Server"
run_list(
         "role[auto-bonded]",
         "recipe[shared-web]",
         "recipe[ipplan]"
)
