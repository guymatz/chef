package "nfs-utils"

service "rpcidmapd" do
  provider Chef::Provider::Service::Init
  supports :start => true, :status => true, :restart => true
  action :start
end

service "rpcbind" do
  provider Chef::Provider::Service::Init
  supports :start => true, :status => true, :restart => true
  action :start
end

directory "#{node[:attivio][:backup_dir]}" do
  owner "attivio"
  group "attivio"
  mode 0755
end

directory "#{node[:attivio][:backup_dir]}/uncompressed" do
  owner "attivio"
  group "attivio"
  mode 0755
end

directory "#{node[:attivio][:backup_dir]}/compressed" do
  owner "attivio"
  group "attivio"
  mode 0755
end

directory "/root/scripts" do
  owner "root"
  group "root"
  mode "0755"
end

template "/home/attivio/do_attivio_bkup.sh" do
  owner "root"
  group "root"
  mode 0755
  variables({
       :backupdir => node[:attivio][:backup_dir],
       :backupsource => node[:attivio][:backup_source]
  })
end

cron_d "attivio_backup" do
  minute        "22"
  hour          "3"
  day           "*"
  weekday       "0"
  command       "/home/attivio/do_attivio_bkup.sh"
  mailto        "ccd-sa@clearchannel.com"
  user          "attivio"
end

remote_file "/root/scripts/check_attivio_backup_corruption.sh" do
  source "http://yum.ihr/files/nagios/check_attivio_backup_corruption.sh"
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
end

remote_file "/root/scripts/check_attivio_backup_freshness.sh" do
  source "http://yum.ihr/files/nagios/check_attivio_backup_freshness.sh"
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
end

remote_file "/root/scripts/check_attivio_backup_size.sh" do
  source "http://yum.ihr/files/nagios/check_attivio_backup_size.sh"
  action :create_if_missing
  owner "root"
  group "root"
  mode "0755"
end

cron_d "check_attivio_backup_corruption" do
  command "/root/scripts/check_attivio_backup_corruption.sh"
  minute  "45"
  hour    "0"
  month   "*"
  weekday "*"
  user    "root"
end

cron_d "check_attivio_backup_freshness" do
  command "/root/scripts/check_attivio_backup_freshness.sh"
  minute  "30"
  hour    "0"
  month   "*"
  weekday "*"
  user    "root"
end

cron_d "check_attivio_backup_size" do
  command "/root/scripts/check_attivio_backup_size.sh"
  minute  "15"
  hour    "0"
  month   "*"
  weekday "*"
  user    "root"
end

nfs_server = search(:node, "role:disaster_recovery AND chef_environment:#{node.chef_environment}")[0]

directory "/data/nfs/dr_backups" do
  recursive true
  action :create
end

mount "/data/nfs/dr_backups" do
  device "#{nfs_server[:hostname]}.ihr:/data/exports/dr_backups"
  fstype "nfs"
  options "noatime,nocto"
  action [:mount, :enable]
end

cron_d "Move_backup_to_NFS_DR" do
  command "/usr/bin/rsync --bwlimit=500 $(/usr/bin/find /data/apps/backups/ -maxdepth 2 -name '*tgz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") /data/nfs/dr_backups/attivio"
  minute  "25"
  hour    "6"
  month   "*"
  weekday "0"
  user    "root"
end
