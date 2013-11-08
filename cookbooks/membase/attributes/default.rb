



default[:membase][:packages] = %w{ membase-server }
default[:membase][:data_path] = "/data/membase/data"
default[:membase][:user] = "membase"
default[:membase][:group] = "membase"
default[:membase][:ulimits] = [ {  
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
