name "zeus"
description "zeus"
run_list(
      "recipe[java]",
      "recipe[zeus-zxtm]"
)
