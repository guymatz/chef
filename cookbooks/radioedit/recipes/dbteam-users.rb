#
# Cookbook Name:: radioedit
# Recipe::dbteam-users
# Description::sets up sudo permission for the database team
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute

# loop through and add sudo for each user in list
node[:radioedit][:user_accounts][:dbteam].each do |u|

  sudo u do
    user u
    commands ["ALL"]
    runas "root"
    nopasswd true
  end
  
end