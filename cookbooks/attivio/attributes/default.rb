
default[:attivio][:aie_install_path] = "/data/apps/attivio"
default[:attivio][:install_path] = "/data/apps/attivio31"
default[:attivio][:config_path] = "/data/apps/attivio31/iheartradio3/conf"
default[:attivio][:user] = "attivio"
default[:attivio][:group] = "attivio"

default[:attivio][:env] = "local"

default[:attivio][:repo] = "git@github.com:iheartradio/attivio.git"
default[:attivio][:rev] = "deploy"

default[:attivio][:packages] = %w{ expect }

default[:attivio][:search_config] = ({
                                       "maxBooleanClauses" => "1000000",
                                       "searchCacheSize" => "50000",
                                       "searchAutowarmFactor" => "0.01",
                                       "searchCacheMaxRows" => "20",
                                       "searchCacheWindow" => "20",
                                       "filterCacheSize" => "25",
                                       "filterAutowarmFactor" => "0.01",
                                       "filterCacheSize" => "25",
                                       "filterAutowarmFactor" => "0.5",
                                       "documentCacheMinSize" => "50000",
                                       "documentCacheMaxSize" => "75000",
                                       "documentCacheLoadFactor" => "0.01" # cache size will be 10% of the segment size
                                     })

default[:attivio][:connector_port] = "19200"
default[:attivio][:indexer_port] = "19100"
default[:attivio][:searcher_port] = "19000"
