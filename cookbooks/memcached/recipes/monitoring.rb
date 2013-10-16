
node[:memcached][:monitoring][:packages].each do |p|
  package p
end

nagios_nrpecheck "Memcached_Machine_Memory" do
  command "#{node['nagios']['plugin_dir']}/check_mem.sh"
  parameters '-w 85 -c 90'
  action :add
end
