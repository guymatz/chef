name "webplayers"
description "webplayers"
all_env = [
           "recipe[webplayer]"
          ]
run_list(all_env)
env_run_lists(
              "_default" => all_env,
              "qa2" => all_env,
              "prod" => all_env + ["role[auto-bonded]"] + ["recipe[splunk::forwarder]"],
              "ec2" => all_env,
              "ec2-prod" => all_env
              )
default_attributes "ganglia" => {
  "gmond_port" => "8650",
  "cluster_name" => "webplayers"
}
override_attributes({
	"splunk" => {
  	   "forwarder_config_folder" => "prod",
           "forwarder_role" => "webplayers"
	}
})
