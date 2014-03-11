nagios_nrpecheck "check_app_proc_tomcat" do
  command "#{node['nagios']['plugin_dir']}/check_procs -C java -a '-Djava.util.logging.config.file=/data/apps/tomcat7/conf/logging.properties'"
  warning_condition "1:1"
  critical_condition "1:1"
end
