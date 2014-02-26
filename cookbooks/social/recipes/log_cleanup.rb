# Delete old facebook logs

cron_d "fbgraph_log_cleanup" do
  hour "*/1"
  minute 0
  command 'rm -f /var/log/fbgraph-consumer/*log.*'
end
