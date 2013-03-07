app_secrets = Chef::EncryptedDataBagItem.load("secrets", "attivio")

template "#{node[:attivio][:config_path]}/iheartradio-#{node.chef_environment}.xml" do
  source "iheartradio-env.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node.chef_environment,
              :search_config => node[:attivio][:search_config],
              :attivio_conf => node[:attivio][:config_path]
            })
end

template "#{node[:attivio][:config_path]}/iheartradio.xml" do
  source "iheartradio.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node.chef_environment
            })
end

template "#{node[:attivio][:config_path]}/iheartradio.#{node.chef_environment}.properties" do
  source "iheartradio.env.properties.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node[:attivio][:env],
              :install_path => node[:attivio][:install_path],
              :connector_port => node[:attivio][:connector_port],
              :indexer_port => node[:attivio][:indexer_port],
              :searcher_port => node[:attivio][:searcher_port],
              :dbconns => app_secrets["#{node.chef_environment}"],
              :directory => node[:attivio][:directory],
              :xml => node[:attivio][:xml],
              :cluster => nil
            })
end

template "#{node[:attivio][:config_path]}/topology-nodes-#{node.chef_environment}.xml" do
  source "topology-nodes-env.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :connector_port => node[:attivio][:connector_port],
              :indexer_port => node[:attivio][:indexer_port],
              :searcher_port => node[:attivio][:searcher_port],
              :cluster => nil
            })
end

directory "#{node[:attivio][:bin_path]}/#{node.chef_environment}" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
end

template "#{node[:attivio][:bin_path]}/#{node.chef_environment}/env.sh" do
  source "env.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_home => node[:attivio][:aie_install_path],
              :attivio_project => node[:attivio][:install_path],
              :zookeeper => nil
            })
end

template "#{node[:attivio][:bin_path]}/#{node.chef_environment}/start-aie-local.sh" do
  source "start-aie-local.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio_mem => node[:attivio][:memory],
              :iheart_env_xml => "#{node[:attivio][:config_path]}/iheartradio-#{node.chef_environment}.xml"
            })
end

file "#{node[:attivio][:aie_install_path]}/conf/attivio.license" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  content app_secrets["license"]
end

