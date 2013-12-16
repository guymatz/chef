#
# Cookbook Name:: jobserver
# Recipe:: fac
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#
# Description: Sets up jobs for FAC-PRN, fac-talk, and fac-music
#              allong with necessary monitoring for the processes and jobs

%w{ default prn music talk radiobuild radiobuild2 updatestream sherpa recommendations }.each do |r|
  include_recipe "fac::#{r}"
end
