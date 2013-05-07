# Install the memcached collector config

include_recipe 'diamond::default'

collector_config "MemcachedCollector" do
  hosts    node['diamond']['collectors']['MemcachedCollector']['hosts']
  path     node['diamond']['collectors']['MemcachedCollector']['path']
end
