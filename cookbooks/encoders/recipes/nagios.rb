nagios_nrpecheck "Check_Vantrix" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  parameters '-C /opt/spotxde/sbin/trx/VATranscoder'
  action :add
end

nagios_nrpecheck "Check_incrond" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  parameters '-C incrond'
  action :add
end
