
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

# drop a github private deploy key for ops-auto
deploy_keys = Chef::EncryptedDataBagItem.load("keys", "ops-auto")
file "/etc/chef/ops-auto" do
  owner "root"
  group "root"
  mode "0400"
  content deploy_keys['private_key']
  :create_if_missing
end

file "/root/.ssh/config" do
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
  Host github.com
    IdentityFile /etc/chef/ops-auto
EOH
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

git_repo = "git@github.com:kplimack/ipplan-autogen.git"

template "#{node[:ipplan][:scripts_dir]}/bin/ipplan-updatefunc.sh" do
  source "ipplan-updatefunc.sh.erb"
  owner "root"
  group "root"
  mode "0700"
  variables({
              :git_repo => git_repo
            })
end

cron "update DNS from IPplan" do
  minute "1,31"
  command "/usr/local/bin/ipplan/ipplan-updatedns.sh"
end
