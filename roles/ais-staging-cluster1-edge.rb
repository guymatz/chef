name 'ais-staging-cluster1-edge'
description 'used to build a staging edge server for AIS'
all_env = [
           'recipe[ais::deploy]'
          ]
run_list(all_env)

env_run_lists(
              '_default' => all_env,
              'staging-hls' => all_env
              )

default_attributes ({
                      'ais' => {
                        'install_id' => 'cchlsedge211013',
                        'cluster_name' => 'staging-cluster1',
                        'ais_type' => 'edge',
                        'version' => '6.2.87-1'
                      }
                    })
