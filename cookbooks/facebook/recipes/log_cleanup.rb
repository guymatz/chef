# Delete old facebook logs

cron_d "fbgraph_log_cleanup" do
  hour "*/1"
  minute 0
  command 'rm -f /var/log/fbgraph-consumer/*log.*'
end

cron_d "fbconsumer_log_cleanup" do
  hour "22"
  command 'find /data/log/facebook-consumer* -type f -mtime +30 -exec rm -rf {} \;'
end
