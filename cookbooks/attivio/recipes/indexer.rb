results = search(:node, "recipes:attivio\\:\\:clustered AND chef_environment:#{node.chef_environment}")

searchers = Array.new
results.each do |r|
  searchers << r["fqdn"]
end

template "/etc/init.d/attivio31-indexer" do
  source "attivio31-indexer.erb"
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

directory "#{node[:attivio][:install_path]}/iheartradio3/logs-#{node["fqdn"]}-indexer" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
end

service "attivio31-indexer" do
  provider Chef::Provider::Service::Init
  supports :status =>true, :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end
