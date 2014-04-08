#
# Cookbook Name:: radioedit
# Recipe::app-restart-script
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
# ########################################

# drop off the radioedit restart script
template "/usr/local/bin/radioedit-restart.sh" do 
  source "radioedit-restart.sh.erb"
  mode "755"
end