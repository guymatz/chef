# Install production rabbit setup

# Setup the management plugin
include_recipe "rabbitmq::mgmt_console"

# Ensure we have all other desired plugins
node[:rabbitmq][:plugins].each do |plugin|
  rabbitmq_plugin plugin do
    action :enable
  end
end

# Setup the amp vhost
rabbitmq_vhost "/amp" do
  action :add
end

# Setup all our users/passwords
users = Chef::EncryptedDataBagItem.load("rabbitmq", "passwords").to_hash
users.each do |k,v|
  next if k == "id"
  rabbitmq_user k do
    password v
    action :add
  end
  rabbitmq_user k do
    vhost "/amp"
    permissions "\".*\" \".*\" \".*\""
    action :set_permissions
  end
end

# Make thumbplay an admin
rabbitmq_user "thumbplay" do
  tags "administrator"
  action :set_tags
end

# Delete the guest user
rabbitmq_user "guest" do
  action :delete
end
