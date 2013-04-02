#
# Cookbook Name:: radioedit
# Recipe::default (core)
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

node[:radioedit][:core][:packages].each do |p|
  package p
end

node[:radioedit][:core][:pips].each do |p|
  python_pip p
end
