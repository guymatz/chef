# #########################################
# Cookbook Name:: elasticsearchnew
# Recipe:: prn_upd_index
# Author:: Gregory Patmore <gregorypatmore@clearchannel.com>
# Description:: Installs a crontab job to trigger an update on the elasticsearch prn index
#
# Copyright 2014, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
# #########################################

cron_d "prn_upd_index" do
  user "root"
  hour "2"
  minute "0"
  command "/usr/bin/nsca_relay -S #{node[:elasticsearchnew][:prn_idx_nagios_service]} -- curl -XPUT -v 'http://#{node[:elasticsearchnew][:prn_idx_host]}:#{node[:elasticsearchnew][:prn_idx_port]}/#{node[:elasticsearchnew][:prn_idx_path]}'"
end