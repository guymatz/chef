# Install production rabbit setup

# Setup the management plugin
include_recipe "rabbitmq::mgmt_console"

# Setup rabbit ulimits
include_recipe "rabbitmq::ulimits"

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
  rabbitmq_user k do
    tags "monitoring"
    action :set_tags
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

# Drop rabbitmqadmin
rabbitmq_admin = "#{node['rabbitmq']['config']}/rabbitmqadmin"
cookbook_file rabbitmq_admin do
  source "admin/rabbitmqadmin"
  mode 0755
  action :create_if_missing
end

# Drop rabbitmq queue/exchange settings json
rabbitmq_settings = "#{node['rabbitmq']['config']}/rabbitmqsettings.json"
template rabbitmq_settings do
  source "amp/rabbitsettings.json"
  notifies :execute, 'bash[install-settings]', :immediately
end

# Load rabbitmq queue/exchange settings
bash "install-settings" do
  code "#{rabbitmq_admin} -u thumbplay -p #{users['thumbplay']} #{rabbitmq_settings}"
  action :nothing
end
