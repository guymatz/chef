# Checks the /data partition
nagios_nrpecheck "Check-Disk-Cassandra" do
  command "#{node['nagios']['plugin_dir']}/check_disk"
  parameters "-p /data"
  warning_condition "45"
  critical_condition "50"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

nagios_nrpecheck "check_app_proc_cassandra" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a 'org.apache.cassandra.service.CassandraDaemon'"
  critical_condition "1:1"
end
