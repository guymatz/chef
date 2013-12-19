package "nfs-utils"

service "rpcidmapd" do
  provider Chef::Provider::Service::Init
  supports :start => true, :status => true, :restart => true, :stop => true
  action :start
end


cron_d "backup-elasticsearch" do
  command "rsync -az #{node[:elasticsearchnew][:ihrsearch_path]}/data #{node[:elasticsearchnew][:backup_server]}:#{node[:elasticsearchnew][:backup_target]}/$(date +\\%Y\\%m\\%d)-${HOSTNAME}"
  minute "0"
  hour "0"
  user "ihr-admin"
end

nfs_server = search(:node, "recipe:disaster_recovery\\:\\:nfs AND chef_environment:#{node.chef_environment}")[0]

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
  command "/usr/bin/rsync -r --bwlimit=500 --delete #{node[:elasticsearchnew][:ihrsearch_path]}/data /data/nfs/dr_backups/elasticsearch/#{node[:hostname]}"
  minute  "0"
  hour    "0"
  month   "*"
  weekday "*"
  user    "root"
end
