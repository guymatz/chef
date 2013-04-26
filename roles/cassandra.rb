name "cassandra"
description "cassandra"
all_env = [
           "recipe[cassandra]",
           "recipe[cassandra::ulimits]",
           "recipe[cassandra::install_from_release]",
           "recipe[cassandra::server]",
           "recipe[cassandra::jna_support]",
           "recipe[cassandra::users]",
           "recipe[cassandra::nagios]",
	  ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
                     "cassandra" => {
                        "cluster_name" => "iad-cassandra1",
                        "concurrent_reads" => "96",
                        "concurrent_writes" => "400",
                        "throttle_limit" => "92",
			"key_cache_size_in_mb" => "0",
			"key_cache_save_period" => "0",
                      }
                   })
override_attributes({
		      "java" => {
			"install_flavor" => "oracle",
			"oracle" => {
			   "accept_oracle_download_terms" => "true"
			}
                      }
                    })
