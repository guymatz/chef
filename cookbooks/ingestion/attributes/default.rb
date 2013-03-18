# Ingestion default attributes
default[:postgres][:user] = "postgres"
default[:postgres][:ulimits] = [ {
                                   "type" => "soft",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 },
                                 {
                                   "type" => "hard",
                                   "item" => "nofile",
                                   "value" => "65535"
                                 }
                               ]
