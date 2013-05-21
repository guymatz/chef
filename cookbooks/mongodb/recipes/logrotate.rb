include_recipe "logrotate"

logrotate_app "mongosd" do
    cookbook "logrotate"
    path "/var/log/mongo/*.log" 
    frequency daily 
    rotate 4
    dateext
    copytruncate
    compress
    notifempty
    extension gz
    sharedscripts
    missingok
end
