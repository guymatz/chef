package "nfs-utils"

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
  command "/usr/bin/rsync --bwlimit=500 $(/usr/bin/find /data/backups/ -name '*archwal.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") /data/nfs/files.ihrdev.com/ing_bak; /usr/bin/rsync $(/usr/bin/find /data/backups/ -name '*data.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") /data/nfs/files.ihrdev.com/ing_bak; /usr/bin/rsync $(/usr/bin/find /data/backups/ -name '*index.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") /data/nfs/files.ihrdev.com/ing_bak;"
  minute  "25"
  hour    "4"
  month   "*"
  weekday "0,3,5"
  user    "root"
end
