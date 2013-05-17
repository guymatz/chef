cron_d "fac_backup" do
  minute        "15"
  hour          "2"
  day           "*"
  weekday       "3"
  command       "/var/lib/mongo/scripts/do_mongobkp.sh > /var/lib/mongo/mongodbbackup.log 2>&1"
  mailto        "CCRDDatabaseOperations@clearchannel.com"
  user          "mongod"
end

directory "/var/lib/mongo/scripts" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

cookbook_file "do_mongobkp.sh" do
  path "/var/lib/mongo/scripts/do_mongobkp.sh"
  mode 0755
  owner "mongod"
  group "mongod"  
  action :create_if_missing
end

directory "#{node[:mongodb][:backupdir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:mongodb][:backupdir]}/compressed" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end
