#
# Cookbook Name:: imagemagick
# Recipe:: default
# Author:: Gregory Patmore <gregorypatmore@clearchannel.com>
# Description:: Installed ImageMagick graphics libs/utils 
# Link:: http://www.imagemagick.org
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
# #########################################

yum_package "ImageMagick" do
  action [ :install ]
end