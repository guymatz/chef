##
## Cookbook Name:: radioedit
## Provider: unicorn
##
## Copyright 2013, iHeartRadio
##
## All rights reserved - Do Not Redistribute
##
## authors:
## jderagon
##
## major refactor for han releaseo
##
## provider to setup all the fun and excitement that comes with a 
## unicorn / nginx / pyhthon app
##
## provides the directory structure, pips, log rotation, startup scripts, etc
##


#
# default provider -- expects to be passed the app name (currently app_api / app_auth)
#
action :init do 
  unless node.tags.include? "radioedit.#{new_resource.deploy_tag}"

    Chef::Log.info("Bootstrapping app #{new_resource.name}")

    # Create directories for application (app home, venv dir, and deployment release directory)
    [ @new_resource.root_dir, @new_resource.env_dir, @new_resource.src_dir ].each do |d|

      directory d do
        owner @new_resource.user
        group @new_resource.user
      end

    end # directories

    # set up the actual application and gunicorn
    application @new_resource.name do

      repository @new_resource.repository
      revision @new_resource.revision
      path @new_resource.root_dir
      owner @new_resource.user
      group @new_resource.user
      enable_submodules @new_resource.enable_submodules

      gunicorn do
        app_module @new_resource.module
        settings_template "re-gunicorn.py.erb"
        port @new_resource.port
        host @new_resource.host
        workers @new_resource.workers
        pidfile @new_resource.pid_file
        stdout_logfile @new_resource.stdout_logfile
        stderr_logfile @new_resource.stderr_logfile
        loglevel @new_resource.loglevel 
        interpreter "python27"
        requirements "requirements.txt"
        autostart @new_resource.autostart
        virtualenv @new_resource.venv_dir
        environment @new_resource.environment
      end # gunicorn
        
    end # application

    # Nginx Config
    template "/etc/nginx/conf.d/#{new_resource.name}.conf" do
      source "nginx-#{new_resource.name}.conf.erb"
      owner "root"
      group "root"
      mode 0600
      variables({
          :app_name =>            @new_resource.name,
          :legacy_static_root =>  @new_resource.legacy_static_root,
          :webserver_port =>      @new_resource.webserver_listen,
      })   
    end

    # Create service init script for application.
    template "/etc/init/#{new_resource.name}.conf" do
        source "radioedit-initd.sh.erb"
        owner "root"
        group "root"
    end

    # set up rotation for the log files
    [ @new_resource.stdout_logfile, @new_resource.stderr_logfile ].uniq.each do |f|
      logrotate_app "#{new_resource.name}.out" do
        cookbook "logrotate"
        path f
        options ["missingok", "compress", "notifempty", "sharedscripts","dateext"]
        frequency "daily"
        enable true
        rotate 5
        size "2G"
        postrotate ' [ -f #{new_resource.pid_file}] && kill -USR1 `cat #{new_resource.pid_file}`'
      end
    end

    # add the tag to prevent unamanaged deploys
    node.tags << "radioedit.#{new_resource.deploy_tag}"

    Chef::Log.info("Initialized app #{new_resource.name}")

  else 
     Chef::Log.warn("App #{new_resource.name} has already been initialized")
  end
end

