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
