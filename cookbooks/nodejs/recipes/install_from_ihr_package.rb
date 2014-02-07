#
# Cookbook Name:: nodejs
# Recipe:: install_from_ihr_package
# Description: Installs nodejs from an rpm in our repo
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# 

%w{ nodejs npm }.each do |p|
  yum_package p; 
end 