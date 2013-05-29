nagios_nrpecheck "Check_INGDB_Backup_Freshness" do
  command "#{node['nagios']['plugin_dir']}/check_ingdb_backup_freshness"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

nagios_nrpecheck "Check_INGDB_Backup_Size" do
  command "#{node['nagios']['plugin_dir']}/check_ingdb_backup_size"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
