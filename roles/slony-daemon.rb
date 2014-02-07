name "slony-daemon"
description "slony-daemon"
all_env = [
	"recipe[postgresql::slony_daemon]"
	  ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env,
              "ec2" => all_env
              )
default_attributes() 
override_attributes({
                    })
