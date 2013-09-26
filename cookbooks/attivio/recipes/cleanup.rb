cron_d "remove_old_logs" do
  hour 1
  minute 0
  command 'find /data/apps/attivio31/iheartradio3/logs*/. -mtime +25 -exec rm {} \; > /dev/null 2>&1'
end
