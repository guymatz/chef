# webserver recipe

app_secrets = Chef::EncryptedDataBagItem.load("secrets", node[:ipplan][:app_name])

results = search(:node, "recipes:ipplan\\:\\:database AND chef_environment:#{node.chef_environment}")
db_server = results[0]

unless db_server.nil?
  mysql_connection_info = {
    :host => db_server['fqdn'],
    :username => "root",
    :password => db_server['mysql']['server_root_password']
  }
end

ruby_block "create_#{node[:ipplan][:app_name]}_db" do
  block do
    %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "CREATE DATABASE #{node[:ipplan][:app_name]};"]
  end
  not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SHOW DATABASES LIKE '#{node[:ipplan][:app_name]}'\;\" | grep #{node[:ipplan][:app_name]}";
  action :create
end

# get a list of webservers hosting ipplan
webservers = search(:node, "role:dns-server")

# grant mysql privs to each ipplan-webserver
webservers.each do |webserver|
  ip = webserver['ipaddress']
  ruby_block "add_#{ip}_#{node[:ipplan][:app_name]}_permissions" do
    Chef::Log.debug("Setting up users and grants")
    block do
      %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "GRANT ALL PRIVILEGES ON #{node[:ipplan][:app_name]}.* to '#{node[:ipplan][:db_user]}'@'#{ip}' IDENTIFIED BY '#{app_secrets['pass']}';"]
    end
    not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SELECT user, host FROM mysql.user\" | grep #{node[:ipplan][:db_user]} | grep #{ip}"
    action :create
  end
end
