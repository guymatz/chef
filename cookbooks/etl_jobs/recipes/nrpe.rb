nagios_nrpecheck "check_app_proc_facebookconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '/home/amqp-consumer/facebook-consumer'"
  critical_condition "1:1"
end
nagios_nrpecheck "check_app_proc_playlogconsumer" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a '/home/amqp-consumer/playlog-consumer'"
  critical_condition "1:1"
end
