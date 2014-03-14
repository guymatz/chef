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

actions :init
default_action :init

# default name attribute
attribute :unicorn, :required => true, :kind_of => String, :name_attribute => true
# user to run the app as
attribute :user, :kind_of => String, :default => "root"
# port listener for app communication
attribute :port, :required => true, :kind_of => [Integer, String]
# severity level for log reporting
attribute :loglevel, :kind_of => String, default => "ERROR", equal_to => %w{ DEBUG, INFO, WARN, ERROR }
attribute :pid_file
attribute :stdout_log
attribute :stderr_log
attribute :root_dir
attribute :venv_dir
attribute :src_dir
attribute :repository
attribute :revision
attribute :workers
attribute :environment
attribute :environment_name
attribute :enable_submodules
attribute :module
attribute :host
attribute :autostart
attribute :deploy_tag
attribute :legacy_static_root
attribute :webserver_listen
