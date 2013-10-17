#
# monbodb::source
#
# Description: Installs mongodb from source at version specified in attributes
#

include_recipe "users::mongo"
if node.chef_environment == "prod" or node.chef_environment == "ec2-prod"
  include_recipe "mongodb::nagios"
end

remote_file "#{Chef::Config[:file_cache_path]}/mongodb-#{node[:mongodb][:source][:version]}.tgz" do
  source "#{node[:mongodb][:source][:url]}-#{node[:mongodb][:source][:version]}.tgz"
  action :create_if_missing
end

bash "extract mongodb source tarball" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
tar -zxvf mongodb-#{node[:mongodb][:source][:version]}.tgz
cp -r mongodb-linux-x86_64-#{node[:mongodb][:source][:version]}/bin/* #{node[:mongodb][:source][:install_path]}
EOH
  not_if "test -f #{node[:mongodb][:source][:install_path]}/mongos"
end

template "/etc/init.d/mongosd" do
  source "mongosd.init.erb"
  mode "0700"
end

directory "/var/log/mongo" do
  owner node[:mongodb][:user]
  group node[:mongodb][:group]
end

service "mongosd" do
  supports :stop => true, :start => true, :restart => true, :status => true
  action [:enable, :start]
end
