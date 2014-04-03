name 'ais-cluster1-edge'
description 'used to build a edge server for AIS'
all_env = [
           'recipe[ais::master_hosts]',
           'recipe[ais::deploy]'
          ]
run_list(all_env)

env_run_lists(
              '_default' => all_env,
              'hls' => all_env
              )

default_attributes ({
                      'ais' => {
                        'install_id' => 'cccarpedge1',
                        'cluster_name' => 'cluster1',
                        'ais_type' => 'edge',
                        'version' => '6.2.81-1',
                        'master_aliases' => ['cluster1.master1.ihr', 'cluster1.master2.ihr'],
                        'master_role' => 'ais-cluster1-master'
                      }
                    })
