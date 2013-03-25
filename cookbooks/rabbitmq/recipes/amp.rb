# Install production rabbit setup

include_recipe "rabbitmq::mgmt_console"

rabbitmq_vhost "/amp" do
  action :add
end

#Setup all our users/passwords
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

rabbitmq_user "thumbplay" do
  tags "administrator"
  action :set_tags
end

rabbitmq_user "guest" do
  action :delete
end
