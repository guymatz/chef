nagios_nrpecheck "check_app_proc_flume-ng" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '/data/apps/flume-ng'"
  critical_condition "1:1"
end
