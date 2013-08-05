name "talk-nrpe"
description "Talk Nagios Checks"
run_list(
         "recipe[encoders::talk_nrpe]"
)
