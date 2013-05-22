#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ users::elasticsearch users::deployer }.each do |cb|
  include_recipe cb
end
