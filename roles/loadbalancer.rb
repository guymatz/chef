name "loadbalancer"
description "HA Proxy Soft-Loadbalancer"
run_list(
         "role[base]",
         "role[monitored]",
         "recipe[haproxy::app_static]"
)

override_attributes(
                    "haproxy" => {
                      "app_server_rule" => "basejump"
                    }
                    )

