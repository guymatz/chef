include_recipe "lvm"

lvm_volume_group 'vg_data' do
        physical_volumes '/dev/sdb1'
        logical_volume 'lv_data' do
            size '75%VG'
            filesystem 'ext4'
            mount_point :location => '/data', :options => 'noatime,nodiratime'
        end
end

cron_d "mongos_backup" do
  minute        "15"
  hour          "1"
  day           "*"
  weekday       "*"
  command       "/var/lib/mongo/scripts/do_mongosbkp.sh > /var/lib/mongo/mongodbbackup.log 2>&1"
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

cookbook_file "do_mongosbkp.sh" do
  path "/var/lib/mongo/scripts/do_mongosbkp.sh"
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

cookbook_file "/root/scripts/check_mongo_usr_backup_corruption.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron_d "check_usr_backup_corruption" do
  command "/root/scripts/check_mongo_usr_backup_corruption.sh"
  minute  "45"
  hour	  "0"
  month	  "*"
  weekday "*"
  user    "root"
end

cron_d "check_usr_backup_freshness" do
  command "/root/scripts/check_mongo_usr_backup_freshness.sh"
  minute  "25"
  hour    "3"
  month   "*"
  weekday "*"
  user    "root"
end

cookbook_file "/root/scripts/check_mongo_usr_backup_freshness.sh" do
  owner "root"
  group "root"
  mode "0755"
end

cron_d "check_usr_backup_size" do
  command "/root/scripts/check_mongo_usr_backup_size.sh"
  minute  "25"
  hour    "2"
  month   "*"
  weekday "*"
  user    "root"
end

cookbook_file "/root/scripts/check_mongo_usr_backup_size.sh" do
  owner "root"
  group "root"
  mode "0755"
end
