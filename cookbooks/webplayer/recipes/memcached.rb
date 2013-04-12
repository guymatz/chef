

# use the normal memcached cookbook and just adjust the settings a little
include_recipe "memcached"

node.set[:memcached][:memory] = "20480"

service "memcached" do
  action [:enable, :start]
  supports :status => true, :start => true, :stop => true, :restart => true
end
