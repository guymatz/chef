
node[:ipplan][:scripts][:packages].each do |p|
  package p
end

directory "#{node[:ipplan][:staging_dir]}" do
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  mode "0755"
end

directory "#{node[:ipplan][:scripts_dir]}" do
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  mode "0755"
end

directory "#{node[:ipplan][:scripts_dir]}/bin" do
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  mode "0755"
end

directory "#{node[:ipplan][:scripts_dir]}/dns/staging" do
  owner "#{node[:apache][:user]}"
  group "#{node[:apache][:group]}"
  mode "0755"
  recursive true
end

if node[:roles].include?('db_master')
  db_server = 'localhost'
else
  results = search(:node, "recipes:ipplan\\:\\:database")
  db_server = results[0][:fqdn]
end
app_secrets = Chef::EncryptedDataBagItem.load("secrets", node[:ipplan][:app_name])

template "#{node[:ipplan][:scripts_dir]}/bin/ipplan-exportdns.pl" do
  source "ipplan-exportdns.pl.erb"
  owner "root"
  group "root"
  mode "0700"
  variables({
              :ipplan_url => node[:ipplan][:ipplan_url],
              :ipplan_user => node[:ipplan][:ipplan_user],
              :db_server => db_server,
              :db_user => node[:ipplan][:db_user],
              :db_pass => app_secrets['pass']
            })
end

template "#{node[:ipplan][:scripts_dir]}/bin/ipplan-updatedns.sh" do
  source "ipplan-updatedns.sh.erb"
  owner node[:apache][:user]
  group node[:apache][:group]
  mode "0755"
  variables({
              :scripts_dir => node[:ipplan][:scripts_dir]
            })
end

results = search(:node, "roles:dns-server")
dns_hosts = Array.new
results.each do |r|
  dns_hosts << r['ipaddress']
end

dns_zones = Array.new
results = search(:dns, "zone:*")
results.each do |r|
  dns_zones << r['zone']
end

template "#{node[:ipplan][:scripts_dir]}/bin/update.conf" do
  source "update.conf.erb"
  owner "root"
  group "root"
  mode "0700"
  variables({
              :work_dir => "#{node[:ipplan][:scripts_dir]}/dns",
              :scripts_dir => node[:ipplan][:scripts_dir],
              :dns_hosts => dns_hosts,
              :dns_zones => dns_zones,
              :install_path => "#{node[:ipplan][:install_path]}"
            })
end

cookbook_file "#{node[:ipplan][:scripts_dir]}/bin/ipplan-updatefunc.sh" do
  source "ipplan-updatefunc.sh"
  owner "root"
  group "root"
  mode "0700"
end
