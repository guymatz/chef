cron_d "clean_backups_pgsql_ing_bak" do
  command "/usr/bin/find /data/exports/files.ihrdev.com/ing_bak -type f -printf '\\%T@ \\%p\\n' | sort -n | cut -d' ' -f2- | head -n -3 | xargs rm"
  minute  "25"
  hour    "6"
  month   "*"
  weekday "*"
  user    "root"
end
