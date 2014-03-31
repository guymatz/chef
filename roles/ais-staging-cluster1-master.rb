name 'ais-staging-cluster1-master'
description 'used to build a staging master server for AIS'
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
                        'install_id' => 'cchlsmaster211013',
                        'cluster_name' => 'staging-cluster1',
                        'ais_type' => 'master',
                        'version' => '6.2.87'
                      }
                    })
