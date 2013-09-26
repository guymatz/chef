include_recipe "logrotate"

logrotate_app "mongo" do
  cookbook "logrotate"
  path "/var/log/mongo/*.log" 
  options [
    "dateext", 
    "copytruncate", 
    "compress",
    "extension gz",
    "sharedscripts",
    "missingok"
  ]
  frequency "daily"
  rotate 4
end