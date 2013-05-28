# Delete old facebook logs

cron_d "fbgraph_log_cleanup" do
  hour 23
  command 'rm -f /var/log/fbgraph-consumer/*log.*'
end
