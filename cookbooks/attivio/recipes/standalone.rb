
template "#{node[:attivio][:config_path]}/iheartradio-#{node[:attivio][:env]}.xml" do
  source "iheartradio-env.xml.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node[:attivio][:env],
              :search_config => node[:attivio][:search_config]
            })
end

template "#{node[:attivio][:config_path]}/iheartradio.#{node[:attivio][:env]}.properties" do
  source "iheartradio.env.properties.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  variables({
              :attivio_env => node[:attivio][:env],
              :connector_port => node[:attivio][:connector_port],
              :indexer_port => node[:attivio][:indexer_port],
              :searcher_port => node[:attivio][:searcher_port],
              :cluster => Array.new
            })
end
