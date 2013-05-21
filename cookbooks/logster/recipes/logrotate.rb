include_recipe "logrotate"

logrotate_app "logster" do
    cookbook "logrotate"
    path "/var/log/logster/*"
    frequency daily 
    rotate 2
    dateext
    copytruncate
    compress
    notifempty
    extension gz
    sharedscripts
    missingok
end
