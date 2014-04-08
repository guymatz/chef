#
# Cookbook Name:: radioedit
# Recipe:: binstore-backup
#
#
#
# All rights reserved - Do Not Redistribute
#
#
# authors: gpatmore
#
# ########################################

template "/usr/local/bin/binstore-backup.sh" do
  source "binstore-backup.sh.erb"
  variables (node[:radioedit][:binstore])
  mode '755'
end