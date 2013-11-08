#
# Cookbook Name:: bastion
# Recipe:: default
#
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
#

%w{ users users::dev users::dba sudo openssh::iptables iptables ntp chef-client operations timezone zsh }.each do |cb|
  include_recipe cb
end

