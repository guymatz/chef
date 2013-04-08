

# use the normal memcached cookbook and just adjust the settings a little
include_recipe "memcached"

node.set[:memcached][:memory] = "20480"
