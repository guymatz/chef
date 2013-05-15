



cron_d "linkinlogs-today" do
  command "ln -nfs /data/logs/$(date +%Y/%m/%d) /data/logs/today"
  minute "0"
  hour "0"
  user "root"
end

cron_d "linkinlogs-yesterday" do
  command "ln -nfs /data/logs/$(date --date yesterday +%Y/%m/%d) /data/logs/yesterday"
  minute "0"
  hour "0"
  user "root"
end
