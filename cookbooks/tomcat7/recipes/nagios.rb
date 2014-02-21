#
# tomcat7::nagios
#
#


nagios_nrpecheck "Tomcat_Process" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C java -a 'org.apache.catalina.startup.Bootstrap start'"
  action :add
end
