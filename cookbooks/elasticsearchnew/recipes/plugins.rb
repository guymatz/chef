
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
    command "#{ES_HOME}/bin/plugin --url #{node[:elasticsearchnew][:url]}/#{node.chef_environment}/es-plugins/es-query-plugin-1.0.zip --install ihr-query"
    cwd Chef::Config[:file_cache_path]
    user node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
  end
  execute "install-ihrsearch-indexer-plugin" do
    command "#{ES_HOME}/bin/plugin --url #{node[:elasticsearchnew][:url]}/#{node.chef_environment}/es-plugins/es-indexer-plugin-1.0.zip --install ihr-index"
    cwd Chef::Config[:file_cache_path]
    notifies :restart, "service[elasticsearch]"
    user node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
  end

  if /stage/ =~ node.chef_environment
      execute "install-river-rabbitmq-plugin" do
      command "#{ES_HOME}/bin/plugin --url #{node[:elasticsearchnew][:url]}/#{node.chef_environment}/es-plugins/elasticsearch-river-rabbitmq.zip --install river-rabbitmq"
      cwd Chef::Config[:file_cache_path]
      notifies :restart, "service[elasticsearch]"
      user node[:elasticsearchnew][:user]
      group node[:elasticsearchnew][:group]
    end
  end

  primary_node=search(:node, "role:elasticsearchnew AND chef_environment:#{node.chef_environment}")[0]

  Chef::Log.info("Primary node info: #{primary_node}")
  Chef::Log.info("Host name info: #{node[:hostname]}")

  if primary_node[:hostname] == node[:hostname]
    execute "configure-river-rabbitmq-plugin" do
      command <<-EOH 
        /usr/bin/curl -XPUT '#{node[:ipaddress]}:9200/_river/my_river/_meta' -d '{ \
          "type" : "rabbitmq", \
          "rabbitmq" : { \
              "addresses" : [ \
                  { \
                      "host" : "iad-stg-rabbitmq101.ihr.", \
                      "port" : 5672 \
                  }, \
                  { \
                      "host" : "iad-stg-rabbitmq102.ihr.", \
                      "port" : 5672 \
                  } \
              ], \
              "user" : "fac", \
              "pass" : "tppw2011!", \
              "vhost" : "/amp", \
              "queue" : "elasticsearch", \
              "exchange" : "elasticsearch", \
              "routing_key" : "elasticsearch", \
              "exchange_declare" : true, \
              "exchange_type" : "direct", \
              "exchange_durable" : true, \
              "queue_declare" : true, \
              "queue_bind" : true, \
              "queue_durable" : true, \
              "queue_auto_delete" : false, \
              "heartbeat" : "30s" \
          }, \
          "index" : { \
              "bulk_size" : 100, \
              "bulk_timeout" : "50ms", \
              "ordered" : false \
          } \
        }' 
        EOH
    end
  end
  tag("es-plugins-installed")
end
