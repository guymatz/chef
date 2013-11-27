results = search(:node, "recipes:attivio\\:\\:clustered AND chef_environment:#{node.chef_environment}")

searchers = Array.new
results.each do |r|
  searchers << "#{r[:hostname]}-v700"
end

template "/etc/init.d/attivio31-searcher" do
  source "attivio31-searcher.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio => node[:attivio],
              :nodename => "#{node[:hostname]}-v700",
              :zookeeper_port => node[:attivio][:zookeeper_port],
              :searchers => searchers,
              :attivio_env => node.chef_environment,
              :searcher => node[:attivio][:searcher]
            })
end

directory "#{node[:attivio][:install_path]}/iheartradio3/logs-#{node["fqdn"]}-searcher" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
end

service "attivio31-searcher" do
  provider Chef::Provider::Service::Init
  supports :status =>true, :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end

#nagios_nrpecheck "Attivio_Process_Searcher" do
#  command "#{node['nagios']['plugin_dir']}/check_procs"
#  warning_condition "1:1"
#  critical_condition "1:1"
#  parameters "-C attivio-java -a searcher"
#  action :add
#end
