# Install the rabbitmq collector config

include_recipe 'diamond::default'

collector_config "RabbitMQCollector" do
  user     node['diamond']['collectors']['RabbitMQCollector']['user']
  password node['diamond']['collectors']['RabbitMQCollector']['password']
  host     node['diamond']['collectors']['RabbitMQCollector']['host']
  path     node['diamond']['collectors']['RabbitMQCollector']['path']
end
