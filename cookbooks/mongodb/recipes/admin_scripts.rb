directory "#{node[:mongodb][:admin_scripts][:dir]}" do
  owner "ihr-deployer"
  group "ihr-deployer"
  mode  00755
  action :create
  recursive true
end

#directory "#{node[:mongodb][:admin_scripts][:dir]}/DB-OPS-QAC1" do
#  owner "root"
#  group "root"
#  mode  00755
#  action :create
#end

git "#{node[:mongodb][:admin_scripts][:dir]}" do
  repository node[:mongodb][:admin_scripts][:repo]
  revision node[:mongodb][:admin_scripts][:rev]
  action :sync
end

bash "chown scripts dir" do
    code "chown -R root. /root/scripts"
end

cron_d "compact_MongoDB" do
  minute "07"
  hour   "11"
  user "root"
  command "/root/scripts/mongodba/bin/compactData.sh -h 127.0.0.1 -p 37017 -f d "
  mailto "irinakaprizkina@clearchannel.com"
end
