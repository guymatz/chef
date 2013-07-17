nagios_nrpecheck "check_app_proc_flumeagent" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/data/apps/flume-ng/conf/flume-conf.properties --name agent'"
  critical_condition "1:1"
end
