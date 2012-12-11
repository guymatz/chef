name "loadbalancer"
description "HA Proxy Soft-Loadbalancer"
run_list(
         "role[base]",
         "recipe[haproxy::app_lb]"
)

override_attributes(
                    "haproxy" => {
                      "app_server_rule" => "basejump"
                    }
                    )

