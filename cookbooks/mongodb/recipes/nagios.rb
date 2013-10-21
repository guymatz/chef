#
# mongodb::nagios
#

nagios_nrpecheck "Mongo_Process_Mongos" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters '-C mongos -a mongosd.conf'
  action :add
end
