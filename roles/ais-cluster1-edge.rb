name 'ais-cluster1-edge'
description 'used to build a edge server for AIS'
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
                        'install_id' => 'cccarpedge1',
                        'cluster_name' => 'cluster1',
                        'ais_type' => 'edge',
                        'version' => '6.2.81'
                      }
                    })
