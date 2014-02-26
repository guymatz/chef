cron_d "update-es-index" do
  minute "0"
  hour "6,14,22"
  weekday "*"
  user "nobody"
  command "/usr/bin/curl -XPUT -v http://#{node[:esearch][:vip]}:9200/_ihr/index/liveStations/_induce"
end
