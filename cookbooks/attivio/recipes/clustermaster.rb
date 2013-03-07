include_recipe "attivio::clustered"
include_recipe "attivio::indexer"
include_recipe "attivio::connector"

template "#{node[:attivio][:bin_path]}/#{node.chef_environment}/deploy_config.sh" do
  source "deploy_config.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio_env => node.chef_environment
            })
end

template "#{node[:attivio][:bin_path]}/#{node.chef_environment}/redeploy_config.sh" do
  source "redeploy_config.sh.erb"
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  variables({
              :attivio_env => node.chef_environment
            })
end
