name "fac"
description "FAC, fac-prn, fac-music, fac-talk"
run_list(
         "recipe[nagios]",
         "recipe[rsyslog]",
         "recipe[monitoring]"
)
