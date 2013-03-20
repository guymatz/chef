# webserver recipe

app_secrets = Chef::EncryptedDataBagItem.load("secrets", "#{node[:basejump][:app_name]}")

results = search(:node, "recipes:basejump\\:\\:database AND chef_environment:#{node.chef_environment}")
db_server = results[0]
if db_server.nil?
  Chef::Log.info("search for basejump database server failed")
  return
end
unless db_server.nil?
  mysql_connection_info = {
    :host => db_server['fqdn'],
    :username => "root",
    :password => db_server['mysql']['server_root_password']
  }
end

ruby_block "create_#{node[:basejump][:app_name]}_db" do
  block do
    %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "CREATE DATABASE #{node[:basejump][:app_name]};"]
  end
  not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SHOW DATABASES LIKE '#{node[:basejump][:app_name]}'\;\" | grep #{node[:basejump][:app_name]}";
  action :create
end

# get a list of webservers hosting basejump
webservers = search(:node, "role:webserver and chef_environment:#{node.chef_environment}")

# grant mysql privs to each webserver
webservers.each do |webserver|
  ip = webserver['ipaddress']
  ruby_block "add_#{ip}_#{node[:basejump][:app_name]}_permissions" do
    Chef::Log.debug("Setting up users and grants")
    block do
      %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "GRANT ALL PRIVILEGES ON #{node[:basejump][:app_name]}.* to '#{node[:basejump][:db_user]}'@'#{ip}' IDENTIFIED BY '#{app_secrets['pass']}';"]
    end
    not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SELECT user, host FROM mysql.user\" | grep #{node[:basejump][:db_user]} | grep #{ip}"
    action :create
  end
end

admins = search(:node, "recipes:basejump\\:\\:tools")
admins.each do |server|
  if defined?(admin['ipaddress'])
    ip = admin['ipaddress']
    ruby_block "add_#{ip}_#{node[:basejump][:app_name]}_permissions" do
      Chef::Log.debug("Setting up users and grants")
      block do
        %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "GRANT SELECT ON #{node[:basejump][:app_name]}.* to '#{node[:basejump][:tools_user]}'@'#{ip}' IDENTIFIED BY '#{app_secrets['tools_pass']}';"]
      end
      not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SELECT user, host FROM mysql.user\" | grep #{node[:basejump][:tools_user]} | grep #{ip}"
      action :create
    end
  end
end
