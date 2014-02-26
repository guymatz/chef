directory "/data/exports/dr_backups/mongo_util_bak/decompressed" do
  owner "root"
  group "root"
  mode 0755
  action :create
end


cron_d "unpack_mongo_util" do
  command "/bin/rm -f /data/exports/dr_backups/mongo_util_bak/decompressed/*; /bin/tar xzf $(/usr/bin/find /data/exports/dr_backups/mongo_util_bak  -name '*tgz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") -C /data/exports/dr_backups/mongo_util_bak/decompressed; /bin/find /data/exports/dr_backups/mongo_util_bak -maxdepth 1 -type f -name '*.tgz' -printf '\\%T@ \\%p\\n' | sort -n | cut -d' ' -f2- | head -n -1 | xargs rm"
  minute  "25"
  hour    "16"
  month   "*"
  weekday "0"
  user    "root"
end
