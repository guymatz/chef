node[:postgresql][:nagios][:packages].each do |p|
  package p
end

# Checks the maximum running time of current queries.
nagios_nrpecheck "Postgres-QueryTime-VIP" do
  command "#{node['nagios']['plugin_dir']}/check_postgres.pl"
  parameters "--action=query_time --excludeuser=postgres"
  warning_condition "4600s"
  critical_condition "5400s"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

# Checks how close databases are to autovacuum_freeze_max_age.
nagios_nrpecheck "Postgres-AutovacFreeze-VIP" do
  command "#{node['nagios']['plugin_dir']}/check_postgres.pl"
  parameters "--action=autovac_freeze"
  warning_condition "85%"
  critical_condition "90%"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

# See how close databases are getting to transaction ID wraparound.
nagios_nrpecheck "Postgres-TxnWraparound-VIP" do
  command "#{node['nagios']['plugin_dir']}/check_postgres.pl"
  parameters "--action=txn_wraparound"
  warning_condition "1_300_000_000"
  critical_condition "1_500_000_000"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end

nagios_nrpecheck "Postgres-Connections-VIP" do
  command "#{node['nagios']['plugin_dir']}/check_postgres.pl"
  parameters "--action=backends"
  warning_condition "80%"
  critical_condition "90%"
  action :add
  notifies :restart, resources(:service => "nagios-nrpe-server")
end
