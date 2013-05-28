
directory "#{node[:elasticsearch][:ihrsearch_path]}/plugins" do
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
  recursive true
end


unless tagged?("es-plugins-installed")
  ES_HOME = node[:elasticsearch][:deploy_path]

  execute "delete plugins" do
    command "rm -rf #{ES_HOME}/plugins/*"
  end

  execute "install-ihrsearch-query-plugin" do
    command "#{ES_HOME}/bin/plugin -url #{node[:elasticsearch][:url]}/es-plugins/es-query-plugin-1.0.zip -install ihr-query"
    cwd Chef::Config[:file_cache_path]
  end
  execute "install-ihrsearch-indexer-plugin" do
    command "#{ES_HOME}/bin/plugin -url #{node[:elasticsearch][:url]}/es-plugins/es-indexer-plugin-1.0.zip -install ihr-index"
    cwd Chef::Config[:file_cache_path]
    notifies :restart, "service[elasticsearch]"
  end

  tag("es-plugins-installed")
end



