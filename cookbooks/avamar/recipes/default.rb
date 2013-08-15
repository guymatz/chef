#
# Cookbook Name:: avamar
# Recipe:: default
#
# Copyright 2013, iHeart
#
# All rights reserved - Do Not Redistribute
#
# untag "avamar_intialized"


# reset for dev
# untag("avamar_initialized")
# untag("avamar_intialized")
# untag("avamar_registered")

# install client rpm, update hosts file, create default dir
avamar node.fqdn do
	action :init
	not_if { node.tags.include?(node[:avamar][:tag_initialized]) }
end

# register a node with the avamar server
avamar node.fqdn do
	action :register
	not_if { node.tags.include?(node[:avamar][:tag_registered]) }
end
