directory "/data/exports/dr_backups/ing_bak/decompressed/data" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

directory "/data/exports/dr_backups/ing_bak/decompressed/index" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

directory "/data/exports/dr_backups/ing_bak/decompressed/archwal" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

cron_d "unpack_ing_data" do
  command "/bin/rm -f /data/exports/dr_backups/ing_bak/decompressed/data/*; /bin/tar xzf $(/usr/bin/find /data/exports/dr_backups/ing_bak  -name '*data.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") -C /data/exports/dr_backups/ing_bak/data/decompressed; /bin/find /data/exports/dr_backups/ing_bak -maxdepth 1 -type f -name '*data.tar.gz' -printf '\\%T@ \\%p\\n' | sort -n | cut -d' ' -f2- | head -n -1 | xargs rm"
  minute  "35"
  hour    "1"
  month   "*"
  weekday "*"
  user    "root"
end

cron_d "unpack_ing_index" do
  command "/bin/rm -f /data/exports/dr_backups/ing_bak/decompressed/index/*; /bin/tar xzf $(/usr/bin/find /data/exports/dr_backups/ing_bak -name '*index.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") -C /data/exports/dr_backups/ing_bak/index/decompressed; /bin/find /data/exports/dr_backups/ing_bak -maxdepth 1 -type f -name '*index.tar.gz' -printf '\\%T@ \\%p\\n' | sort -n | cut -d' ' -f2- | head -n -1 | xargs rm"
  minute  "50"
  hour    "1"
  month   "*"
  weekday "*"
  user    "root"
end

cron_d "unpack_ing_archwal" do
  command "/bin/rm -f /data/exports/dr_backups/ing_bak/decompressed/archwal/*; /bin/tar xzf $(/usr/bin/find /data/exports/dr_backups/ing_bak -name '*archwal.tar.gz' -type f -printf '\\%T@ \\%p\\n' | sort -n | tail -1 | cut -f2- -d\" \") -C /data/exports/dr_backups/ing_bak/archwal/decompressed; /bin/find /data/exports/dr_backups/ing_bak -maxdepth 1 -type f -name '*archwal.tar.gz' -printf '\\%T@ \\%p\\n' | sort -n | cut -d' ' -f2- | head -n -1 | xargs rm"
  minute  "20"
  hour    "2"
  month   "*"
  weekday "*"
  user    "root"
end
