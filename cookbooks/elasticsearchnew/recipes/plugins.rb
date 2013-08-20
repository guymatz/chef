
directory "#{node[:elasticsearchnew][:ihrsearch_path]}/plugins" do
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  recursive true
end


unless tagged?("es-plugins-installed")
  ES_HOME = node[:elasticsearchnew][:deploy_path]

  execute "delete plugins" do
    command "rm -rf #{ES_HOME}/plugins/*"
  end

  execute "install-ihrsearch-query-plugin" do
    command "#{ES_HOME}/bin/plugin --url #{node[:elasticsearchnew][:url]}/es-plugins/es-query-plugin-1.0.zip --install ihr-query"
    cwd Chef::Config[:file_cache_path]
    user node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
  end
  execute "install-ihrsearch-indexer-plugin" do
    command "#{ES_HOME}/bin/plugin --url #{node[:elasticsearchnew][:url]}/es-plugins/es-indexer-plugin-1.0.zip --install ihr-index"
    cwd Chef::Config[:file_cache_path]
    notifies :restart, "service[elasticsearch]"
    user node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
  end

  tag("es-plugins-installed")
end



