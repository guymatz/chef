#
# mongodb::nagios
#
# written by Jake Plimack <jake.plimack@gmail.com>
#
#

nagios_nrpecheck "Mongo_Process_Mongos" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters '-C mongos -a mongosd.conf'
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
