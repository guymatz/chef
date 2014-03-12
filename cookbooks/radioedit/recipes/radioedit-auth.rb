#
# Cookbook Name:: radioedit-auth
# Recipe:: radioedit-auth
#
#
#
# All rights reserved - Do Not Redistribute
# Installs/deploys the radioedit app server
#
#
# authors:  jderagon
# 
#  Sun Feb 23 13:50:23 EST 2014
# 
#  Stub to setup the auth service
## dev testing
untag("radioedit.app_auth")

#
# call the provider for app-auth 
#
radioedit_unicorn "app_auth" do
    action :init
    #not_if { node.tags.include?(radioedit.app-auth) }
end

