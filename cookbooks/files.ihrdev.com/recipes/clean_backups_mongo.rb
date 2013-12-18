cron_d "clean_backups_mongo" do
  command "/usr/bin/find /data/exports/files.ihrdev.com/mongo_fac_bak /data/exports/files.ihrdev.com/mongo_usr_bak /data/exports/files.ihrdev.com/mongo_util_bak -type f -printf '\\%T@ \\%P\\n' | sort -n | cut -d' ' -f2- | head -n -1 | xargs rm"
  minute  "25"
  hour    "6"
  month   "*"
  weekday "*"
  user    "root"
end
