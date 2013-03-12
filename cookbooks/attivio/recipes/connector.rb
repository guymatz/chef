results = search(:node, "recipes:attivio\\:\\:clustered AND chef_environment:#{node.chef_environment}")

searchers = Array.new
results.each do |r|
  searchers << r["fqdn"]
end

template "/etc/init.d/attivio31-connector" do
  source "attivio31-connector.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio => node[:attivio],
              :nodename => node[:fqdn],
              :zookeeper_port => node[:attivio][:zookeeper_port],
              :searchers => searchers,
              :attivio_env => node.chef_environment,
              :indexer => node[:attivio][:indexer]
            })
end

service "attivio31-connector" do
  provider Chef::Provider::Service::Init
  supports :status =>true, :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end

nagios_nrpecheck "Attivio_Process_Connector" do
  command "#{node['nagios']['plugin_dir']}/check_procs"
  warning_condition "1:1"
  critical_condition "1:1"
  parameters "-C attivio-java -a connector1"
  action :add
end

