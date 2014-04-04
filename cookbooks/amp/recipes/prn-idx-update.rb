# #################################################
# @FILE: prn-idx-update.rb
# @AUTHOR: :GregoryPatmore <gregorypatmore@clearchannel.com>}
# @CHEF-COOKBOOK: amp
# @PROJECT: prn index update crontab 
# @TICKETID: OPS-6357
# @TAB-SIZE: 2
# @SOFT-TABS: YES
# @DESC: installs the prn index update crontab task
# @NOTES: 
# #################################################

#create a dir to drop 
directory "/data/apps/prn-idx-update"

template "/data/apps/prn-idx-update/prn-idxupdate.sh" do
  souce "prn-idxupdate.sh.erb"
  owner 'root'
  group 'root'
  mode "744"
end 

cron_d "prn-index-update" do
  hour "*/6"
  command "/data/apps/prn-idx-update/prn-idxupdate.sh > /data/apps/prn-idx-update/prn-idxupdate.last_run.out 2>&1"
end


