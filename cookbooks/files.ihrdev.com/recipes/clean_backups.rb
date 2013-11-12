cron_d "clean_backups" do
  command "/usr/bin/find /data/exports/files.ihrdev.com/auth_bak /data/exports/files.ihrdev.com/ing_bak /data/exports/files.ihrdev.com/mongo_fac_bak /data/exports/files.ihrdev.com/mongo_usr_bak /data/exports/files.ihrdev.com/mongo_util_bak -type f -mtime +7 -exec rm -f {} \;"
  minute  "25"
  hour    "6"
  month   "*"
  weekday "3"
  user    "root"
end
