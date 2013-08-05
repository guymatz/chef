name "amp-logger"
description "amp-logger"
run_list(
         "role[auto-bonded]",
         "recipe[amp::logger]",
         "recipe[amp::logger_nrpe]"
)
