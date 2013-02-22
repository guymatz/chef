name "monitored"
description "Sets up Nagios, Rsyslog, Ganglia"
run_list(
         "recipe[nagios::client]",
         "recipe[rsyslog]"
)
