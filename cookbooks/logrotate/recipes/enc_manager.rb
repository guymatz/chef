# #######################################################
# @CREATED 7/30/13 
# @AUTHOR Gregory Patmore
# @CONTACT gregorypatmore@clearchannel.com
# @DESC Implements logrotate management for anything ending in .log within the /var/log/manager dir
# @REF https://jira.ccrd.clearchannel.com/browse/OPS-4768
# 
# #######################################################
logrotate_app "enc_manager" do
    path "/var/log/manager/*.log"
    frequency "daily"
    rotate 4
    options ["missingok", "compress", "copytruncate", "notifempty"]
    create "644 root root"
end