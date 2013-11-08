nagios_nrpecheck "MixIn_Manager_Running" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  parameters '-C mixin_manager.rb'
  action :add
end

nagios_nrpecheck "MixIn_Converter_Running" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  parameters '-C mixin_converter.rb'
  action :add
end
