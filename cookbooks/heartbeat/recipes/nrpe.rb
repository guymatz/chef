#NRPE checks for Heartbeat

case node.chef_environment
when "development" #do nothing
else
	nagios_nrpecheck "check_app_proc_heartbeat" do
	  command "#{node['nagios']['plugin_dir']}/check_procs -a 'heartbeat'"
	  critical_condition "4:5"
	end
end
