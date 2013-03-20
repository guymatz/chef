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
                                 },
                                 {
                                   "type" => "soft",
                                   "item" => "nproc",
                                   "value" => "unlimited"
                                 },
                                 {
                                   "type" => "hard",
                                   "item" => "nproc",
                                   "value" => "unlimited"
                                 }
                               ]
