include_recipe "logrotate"

logrotate_app "jboss" do
    cookbook "logrotate"
    path "/data/jboss_4_0_5/server/ingestion/log"
    frequency "daily"
    rotate 4
    compress true
    create "644 root root"
end

