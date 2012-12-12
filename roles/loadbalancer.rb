name "loadbalancer"
description "HA Proxy Soft-Loadbalancer"
run_list(
         "role[base]",
         "role[monitored]",
         "recipe[haproxy::app_lb2]"
)

override_attributes(
                    "haproxy" => {
                      "app_server_rule" => "basejump"
                    }
                    )

