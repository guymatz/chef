##
### Cookbook Name:: radioedit
### Provider: unicorn
###
### Copyright 2013, iHeartRadio
###
### All rights reserved - Do Not Redistribute
###
### authors:
### jderagon
###
### major refactor for han releaseo
### this provides the setup of a python/gunicorn app
###

attribute :unicorn, :kind_of => String, :name_attribute => true

actions :init
default_action :init
