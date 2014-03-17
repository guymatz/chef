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
### @Changelog 
###   - 3/17/14 GP
###     - Refactored to add attribute definitions for external data sources, moving impetus to recipe to send in the right values
###     - This allows us to push out changes to try/test without having to recode the provider.
###

# exposed actions
actions :init
# implied action when none given
default_action :init

# default name attribute
attribute :unicorn, :required => true, :kind_of => String, :name_attribute => true
# user to run the app as
attribute :user, :kind_of => String, :default => "root"
# the webserver host
attribute :host, :required => true, :kind_of => String
# port listener for app communication
attribute :port, :required => true, :kind_of => [Integer, String]
# severity level for log reporting
attribute :log_level, :kind_of => String, default => "ERROR", equal_to => [ "DEBUG", "INFO", "WARN", "ERROR" ]
# path to the pid file to create
attribute :pid_file, :required => true, :kind_of => String
# path to the stdout process log
attribute :stdout_log, :required => true, :kind_of => String 
# path to the stderr process log
attribute :stderr_log, :required => true, :kind_of => String 
# path to the root directory of the app
attribute :root_dir, :required => true, :kind_of => String 
# path to the virtual environment directory
attribute :venv_dir, :required => true, :kind_of => String
# path to the revision directory 
attribute :src_dir, :required => true, :kind_of => String 
# uri for the git repo
attribute :repository, :required => true, :kind_of => String 
# git tag or branch name to deploy
attribute :revision, :required => true, :kind_of => String
# switch to enable git submodule management (defaults to true, which is what you should usually want)
attribute :enable_submodules, :kind_of => [TrueClass, FalseClass], :default => true
# number of worker processes to spawn (defaults to most common value = 5)
attribute :workers, :kind_of => [Integer, String], :default => 5
# Hash of varname => value pairs added to the supervisor conf and exported at process runtime
attribute :environment, :required => true, :kind_of => Hash 
# the unicorn module to run
attribute :app_module, :kind_of => String, :default => "wsgi" 
# switch to indicate whether you want the application to automatically start when supervisor starts (defaults to true ---most common option we use)
attribute :autostart, :kind_of => [TrueClass, FalseClass], :default => true
# the chef tag to watch and set when checking if a deployment is required during a run
attribute :deploy_tag, :required => true, :kind_of => String 
# static directory for supporting legacy requirement for serving static files
attribute :legacy_static_root, :required => true, :kind_of => String 
# what port nginx should listen on
attribute :webserver_listen, :required => true, :kind_of => String 



