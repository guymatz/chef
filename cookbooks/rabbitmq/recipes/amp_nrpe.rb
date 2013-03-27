# AMP rabbitmq nrpe checks

# Install required perl packages

package "perl-Nagios-Plugin"
package "perl-URI"
package "perl-JSON"

# Get the nagios user/pass
users = Chef::EncryptedDataBagItem.load("rabbitmq", "passwords").to_hash

nagios_nrpecheck "check_rabbitmq_aliveness" do
  command "#{node[:nagios][:plugin_dir]}/check_rabbitmq_aliveness -H localhost -u nagios -p #{users["nagios"]} --vhost='/amp'"
  action :add
end

nagios_nrpecheck "check_rabbitmq_overview" do
  command "#{node[:nagios][:plugin_dir]}/check_rabbitmq_overview -H localhost -u nagios -p #{users["nagios"]}"
  warning_condition "5000,5000,5000"
  critical_condition "10000,10000,10000"
  action :add
end
