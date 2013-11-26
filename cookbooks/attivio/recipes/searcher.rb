results = search(:node, "recipes:attivio\\:\\:clustered AND chef_environment:#{node.chef_environment}")

searchers = Array.new
results.each do |r|
  searchers << r["fqdn"]
end

template "/etc/init.d/attivio31-searcher" do
  source "attivio31-searcher.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio => node[:attivio],
              :nodename => node[:fqdn],
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

template "#{node['nagios']['plugin_dir']}/check_attivio_available.sh" do
  owner node[:nagios][:user]
  group node[:nagios][:group]
  mode 0777
  source "check_attivio_available.sh.erb"
end

nagios_nrpecheck "Attivio_Searcher_Available" do 
  command "#{node['nagios']['plugin_dir']}/check_attivio_available.sh"
end
