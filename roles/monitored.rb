name "monitored"
description "Sets up Nagios, Rsyslog"
run_list(
         "recipe[rsyslog::client]",
         "recipe[nagios::client]"
)
