### 
### Logrotator for all encoder boxes
### luckily something is standarized on the encoders
### mainly, all logs are in /var/log/manager
###

logrotate_app "managerlogs" do
    path "/var/log/manager/*.log"
    options ["missingok", "copytruncate", "compress", "notifempty"]
    frequency "daily"
    enable true
    create "0644 nobody root"
    rotate 2
end
