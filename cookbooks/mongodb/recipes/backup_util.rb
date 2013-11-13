package "nfs-utils"

service "rpcbind" do
  action [:start, :enable]
end

cron_d "util_backup" do
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

directory "#{node[:mongodb][:backupdir]}/uncompressed" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

directory "/root/scripts" do
  owner "root"
  group "root"
  mode "0755"
end

cookbook_file "/root/scripts/check_mongo_util_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron_d "check_mongo_util_backup_corruption" do
  command "/root/scripts/check_mongo_util_backup_corruption.sh"
  minute  "45"
  hour	  "0"
  month	  "*"
  weekday "*"
  user    "root"
end

cron_d "check_mongo_util_backup_freshness" do
  command "/root/scripts/check_mongo_util_backup_freshness.sh"
  minute  "25"
  hour    "3"
  month   "*"
  weekday "*"
  user    "root"
end

cookbook_file "/root/scripts/check_mongo_util_backup_freshness.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron_d "check_mongo_util_backup_size" do
  command "/root/scripts/check_mongo_util_backup_size.sh"
  minute  "25"
  hour    "2"
  month   "*"
  weekday "*"
  user    "root"
end

cookbook_file "/root/scripts/check_mongo_util_backup_size.sh" do
  owner "root"
  group "root"
  mode "0755"
end

nfs_server = search(:node, "recipe:files.ihrdev.com\\:\\:nfs AND chef_environment:#{node.chef_environment}")[0]

directory "/data/nfs/files.ihrdev.com" do
  action :create
  recursive true
end

mount "/data/nfs/files.ihrdev.com" do
  device "#{nfs_server[:hostname]}-v600.ihr:/data/exports/files.ihrdev.com"
  fstype "nfs"
  options "noatime,nocto"
  action [:mount, :enable]
end

cron_d "Move_backup_to_NFS" do
  command "/bin/cp $(/usr/bin/find /data/db/backups/ -maxdepth 1 -name '*tarz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") /data/nfs/files.ihrdev.com/mongo_util_bak"
  minute  "25"
  hour    "6"
  month   "*"
  weekday "3"
  user    "root"
end
