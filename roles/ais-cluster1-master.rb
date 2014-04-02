name 'ais-cluster1-master'
description 'used to build a master server for AIS'
all_env = [
           'recipe[ais::deploy]'
          ]
run_list(all_env)

env_run_lists(
              '_default' => all_env,
              'qa2' => all_env,
              'dev' => all_env,
              'prod' => all_env,
              'ec2-prod' => all_env,
              'ec2' => all_env,
              'hls' => all_env
              )

default_attributes ({
                      'ais' => {
                        'install_id' => 'cccarpmaster1',
                        'cluster_name' => 'cluster1',
                        'ais_type' => 'master',
                        'version' => '6.2.81-1'
                      }
                    })
