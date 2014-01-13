name "mongodb_backups"
description "mongodb_backups"
all_env = [
	  ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes({
	'nagios' => {
		'nrpe' => {
			'command_timeout' => "1800"
			}
		}
                   }) 
override_attributes({
                    })
