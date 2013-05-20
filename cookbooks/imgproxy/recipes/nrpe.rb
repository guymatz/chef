# imgproxy nrpe checks

nagios_nrpecheck "check_varnish_ratio" do
  command "#{node['nagios']['plugin_dir']}/check_varnish"
  warning_condition "75:"
  critical_condition "70:"
end

nagios_nrpecheck "check_app_proc_varnishd" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a 'varnish'"
  critical_condition "2:3"
end

nagios_nrpecheck "check_app_proc_nginx" do
  command "#{node['nagios']['plugin_dir']}/check_procs -a 'nginx'"
  critical_condition "5:5"
end
