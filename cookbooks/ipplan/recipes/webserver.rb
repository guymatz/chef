# webserver recipe

include_recipe "apache2"
include_recipe "apache2::mod_php5"

version = node[:ipplan][:version]

node[:ipplan][:packages].each do |p|
  package p
end

remote_file "#{Chef::Config[:file_cache_path]}/ipplan-#{version}.tar.gz" do
  puts "Downloading from #{node[:ipplan][:package_url]}"
  source node[:ipplan][:package_url]
  #  checksum node[:ipplan][:checksum]
  action :create_if_missing
end

directory node[:ipplan][:install_path] do
  owner node[:apache][:user]
  group node[:apache][:group]
  mode 0750
  recursive true
end

bash "extract-package" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxvf ipplan-#{version}.tar.gz
    mv ipplan/* #{node[:ipplan][:install_path]}
  EOH
  not_if "test -f #{node[:ipplan][:install_path]}/index.php"
end

# setup the apache virtualhost

web_app node[:ipplan][:app_name] do
  server_name node[:ipplan][:server_name]
  docroot node[:ipplan][:install_path]
  server_aliases node[:ipplan][:server_aliases], node['fqdn'], node['hostname']
  template "#{node[:ipplan][:app_name]}.conf.erb"
end

if node[:roles].include?('db_master')
  db_server = 'localhost'
else
  results = search(:node, "role:ipplan-database")
  db_server = results.first[:fqdn]
end


app_secrets = Chef::EncryptedDataBagItem.load("secrets", node[:ipplan][:app_name])

Chef::Log.info("Configuring IPplan settings:")
Chef::Log.debug("DBSERVER:" + db_server)
Chef::Log.debug("DBUSER:" + node[:ipplan][:db_user])
Chef::Log.debug("DBNAME:" + node[:ipplan][:app_name])
Chef::Log.debug("EXPORTPATH:" + "#{node[:ipplan][:scripts_dir]}/dns")

template "#{node[:ipplan][:install_path]}/config.php" do
  source "config.php.erb"
  mode "0755"
  variables({
              :db_server => db_server,
              :db_user => node[:ipplan][:db_user],
              :db_pass => app_secrets['pass'],
              :db_name => node[:ipplan][:app_name],
              :ipplan_export_path => "#{node[:ipplan][:scripts_dir]}/dns"
            })
end

include_recipe "ipplan::pushdns"
include_recipe "ipplan::scripts"
