

app_secrets = Chef::EncryptedDataBagItem.load("secrets", node[:hive][:app_name])

results = search(:node, "recipes:hive\\:\\:mysql AND chef_environment:#{node.chef_environment}")
db_server = results[0]

unless db_server.nil?
  mysql_connection_info = {
    :host => db_server['fqdn'],
    :username => "root",
    :password => db_server['mysql']['server_root_password']
  }
end

cookbook_file "#{Chef::Config[:file_cache_path]}/#{node[:hive][:mysql_migration_script]}" do
  source node[:hive][:mysql_migration_script]
  mode "0755"
  user "root"
  group "root"
  action :create_if_missing
end

ruby_block "create_#{node[:hive][:app_name]}_db" do
  block do
    %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "CREATE DATABASE #{node[:hive][:db_name]}; USE #{node[:hive][:db_name]}; SOURCE #{Chef::Config[:file_cache_path]}/#{node[:hive][:mysql_migration_script]};"]
  end
  not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SHOW DATABASES LIKE '#{node[:hive][:db_name]}'\;\" | grep #{node[:hive][:db_name]}";
  action :create
end

hiveservers = search(:node, "role:hadoop")

results = search(:hadoop, "id:hive")
results[0]['servers'].each do |r|
  hiveservers << r
end

hiveservers.each do |h|
  ip = h['ipaddress']
  ruby_block "add_#{ip}_#{node[:hive][:app_name]}_permissions" do
    Chef::Log.debug("Setting up users and grants")
    block do
      %x[mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e "GRANT ALL PRIVILEGES ON #{node[:hive][:db_name]}.* to '#{node[:hive][:db_user]}'@'#{ip}' IDENTIFIED BY '#{app_secrets['pass']}';"]
    end
    not_if "mysql -u #{mysql_connection_info[:username]} -p#{mysql_connection_info[:password]} -e \"SELECT user, host FROM mysql.user\" | grep #{node[:hive][:db_user]} | grep #{ip}"
    action :create
  end
end

