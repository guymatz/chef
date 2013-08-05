# #######################################################
# @CREATED 8/5/13
# @AUTHOR Gregory Patmore
# @CONTACT gregorypatmore@clearchannel.com
# @DESC Logging Client Group
# @REF https://jira.ccrd.clearchannel.com/browse/OPS-4588
# 
# #######################################################

logrotate_app "search-queries-logs" do
  path '/data/apps/attivio31/iheartradio3/logs-iad-search101.prod.ihr-searcher/querylogs/'
  options ["compress"]
  frequency "daily"
  rotate 14
end

logrotate_app "search-zookeeper-logs" do
  path '/data/apps/attivio31/iheartradio3/logs-iad-search101.prod.ihr-searcher/zookeeper.log*'
  options ["compress"]
  frequency "daily"
  rotate 14
end

logrotate_app "search-jetty-req-logs" do
  path '/data/apps/attivio31/iheartradio3/logs-iad-search101.prod.ihr-searcher/jetty-*.request.*.log'
  options ["compress"]
  frequency "daily"
  rotate 14
end

logrotate_app "search-attivio-logs" do
  path '/data/apps/attivio31/iheartradio3/logs-iad-search101.prod.ihr-searcher/attivio.log*'
  options ["compress"]
  frequency "daily"
  rotate 14
end

logrotate_app "search-attivio-errs-logs" do
  path '/data/apps/attivio31/iheartradio3/logs-iad-search101.prod.ihr-searcher/attivio.error.log*'
  options ["compress"]
  frequency "daily"
  rotate 14
end