#
# Cookbook Name:: cnp
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#


node[:cnp][:pips].each do |p|
    python_pip p
end
