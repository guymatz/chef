name "monitored"
description "Sets up Nagios, Rsyslog, Ganglia"
run_list(
         "recipe[nagios]",
         "recipe[rsyslog]",
         "recipe[monitoring]"
)
