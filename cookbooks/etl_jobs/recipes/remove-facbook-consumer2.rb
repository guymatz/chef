
directory "/home/amqp-consumer/facebook-consumer-2" do
  action :delete
end
directory "/data/log/facebook-consumer-2" do
  action :delete
end
directory "/var/run/facebook-consumer-2" do
  action :delete
end
remote_file "/home/amqp-consumer/facebook-consumer-2/facebook_consumer.jar" do
  action :delete 
end
remote_file "/home/amqp-consumer/facebook-consumer-2/env.properties" do
  action :delete
end
remote_file "/home/amqp-consumer/facebook-consumer-2/log4j.xml" do
  action :delete
end
remote_file "/etc/init.d/facebook-consumer-2" do
  action :delete
end
