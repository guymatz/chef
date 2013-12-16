# For the couchbase bucket memory usage checks

nagios_nrpecheck "Check_CBM_catalog" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b catalog --memory-used -W 3774873600 -C 3984588800'
  action :add
end

nagios_nrpecheck "Check_CBM_default" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b default --memory-used -W 56623104000 -C 59768832000'
  action :add
end

nagios_nrpecheck "Check_CBM_l3stream" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b l3stream --memory-used -W 3865470566 -C 4080218931'
  action :add
end

nagios_nrpecheck "Check_CBM_live-episodes" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b live-episodes --memory-used -W 3865470566 -C 4080218931'
  action :add
end

nagios_nrpecheck "Check_CBM_radio-sessions" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b custom-radio-sessions --memory-used -W 18874368000 -C 19922944000'
  action :add
end

nagios_nrpecheck "Check_CBM_search" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b search --memory-used -W 7549747200 -C 7969177600'
  action :add
end

nagios_nrpecheck "Check_CBM_sessions" do
  command "#{node['nagios']['plugin_dir']}/check_couchbase.py"
  parameters '-u Administrator -p Thumbplay1 -I localhost -P 8091 -b sessions --memory-used -W 11596411699 -C 12240656793'
  action :add
end
