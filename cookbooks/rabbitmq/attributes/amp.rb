default[:rabbitmq][:plugins] = [ "amqp_client",
                                 "mochiweb",
                                 "rabbitmq_management",
                                 "rabbitmq_management_agent",
                                 "webmachine"
                               ]

default[:rabbitmq][:ulimits] = [{
                                  "type" => "hard",
                                  "item" => "nofile",
                                  "value" => "390000"
                                },
                                {
                                  "type" => "soft",
                                  "item" => "nofile",
                                  "value" => "390000"
                                }]
