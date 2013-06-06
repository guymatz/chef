all_secrets = Chef::EncryptedDataBagItem.load("secrets", "sonos")
app_secrets = all_secrets[node.chef_environment]

results = search(:node, "role:sonos-database AND chef_environment:#{node.chef_environment}")
db_server = results.first
if db_server.nil?
  Chef::Log.info("search for sonos database server failed")
  return
end
unless db_server.nil?
  mysql_connection_info = {
    :host => db_server[:fqdn],
    :username => "root",
    :password => db_server[:mysql][:server_root_password]
  }
end

db_name = "sonos_#{node.chef_environment}".gsub('-', '_')

ruby_block "create_sonos_db" do
  block do
    %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "CREATE DATABASE #{db_name};"]
  end
  not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SHOW DATABASES LIKE '#{db_name}';\" | grep #{db_name}";
  action :create
end

# get a list of webservers hosting sonos
webservers = search(:node, "role:sonos and chef_environment:#{node.chef_environment}")

# grant mysql privs to each webserver
webservers.each do |webserver|
  ip = webserver['ipaddress']
  ruby_block "add_#{ip}_#{db_name}_permissions" do
    Chef::Log.debug("Setting up users and grants")
    block do
      %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "GRANT ALL PRIVILEGES ON #{db_name}.* to '#{app_secrets['db_user']}'@'#{ip}' IDENTIFIED BY '#{app_secrets['db_pass']}';"]
    end
    not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SELECT user, host FROM mysql.user;\" | grep #{app_secrets['db_user']} | grep #{ip}"
    action :create
  end
end
