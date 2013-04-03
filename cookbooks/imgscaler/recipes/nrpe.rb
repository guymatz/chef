# imgscaler nrpe checks

nagios_nrpecheck "check_app_proc_tomcat" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a 'tomcat'"
  critical_condition "1:1"
end
