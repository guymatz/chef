##
## Cookbook Name:: radioedit
## Provider: unicorn
##
## Copyright 2013, iHeartRadio
##
## All rights reserved - Do Not Redistribute
##
## authors:
## jderagon, gpatmore
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

  new_resource = @new_resource

  unless node.tags.include? "radioedit.#{new_resource.deploy_tag}" && node.chef_environment !~ /^prod/

    Chef::Log.info("Bootstrapping app #{new_resource.name}")

    # Create directories for application (app home, venv dir, and deployment release directory)
    [ new_resource.root_dir, new_resource.venv_dir, new_resource.src_dir ].each do |d|

      directory d do
        owner new_resource.user
        group new_resource.user
      end

    end # directories

    # touch the log files to make sure they have the proper perms
    [ new_resource.stdout_log, new_resource.stderr_log ].uniq.each do |f|

      file f do
        owner new_resource.user
        group new_resource.user
        mode "0755"
        action :touch
      end

    end



    # set up the actual application and gunicorn
    application "#{new_resource.name}" do

      repository new_resource.repository
      revision new_resource.revision
      path new_resource.root_dir
      owner new_resource.user      
      group new_resource.user
      enable_submodules new_resource.enable_submodules

      # unicorn sub resource
      gunicorn do
        app_module new_resource.app_module
        settings_template "re-gunicorn.py.erb"
        port new_resource.port
        host new_resource.host
        workers new_resource.workers
        pidfile new_resource.pid_file
        stdout_logfile new_resource.stdout_log
        stderr_logfile new_resource.stderr_log
        loglevel new_resource.log_level 
        interpreter "python27"
        requirements "requirements.txt"
        autostart new_resource.autostart
        virtualenv new_resource.venv_dir
        environment new_resource.environment
      end # gunicorn
        
    end # application

    # Nginx Config
    template "/etc/nginx/conf.d/#{new_resource.name}.conf" do
      source "nginx-#{new_resource.name}.conf.erb"
      owner "root"
      group "root"
      mode 0600
      variables({
          :app_name             => new_resource.name,
          :server_host          => new_resource.host,
          :server_port          => new_resource.port,
          :webserver_name       => new_resource.webserver_name,
          :webserver_port       => new_resource.webserver_listen,
          :legacy_static_root   => new_resource.legacy_static_root
      })   
    end

    # Create service init script for application.
    template "/etc/init/#{new_resource.name}.conf" do
      source "radioedit-initd.sh.erb"
      owner "root"
      group "root"
    end

    # set up rotation for the log files (using unique in case both attributes are set to the same thing)
    [ @new_resource.stdout_log, @new_resource.stderr_log ].uniq.each do |f|
      logrotate_app "#{new_resource.name}.out" do
        cookbook "logrotate"
        path f
        frequency "daily"
        enable true
        rotate 5
        size "2G"
        options %w{ missingok compress notifempty sharedscripts dateext }
        postrotate '[ -f #{new_resource.pid_file}] && kill -USR1 `cat #{new_resource.pid_file}`'
      end
    end

    # add the tag to prevent unamanaged deploys
    node.tags << "radioedit.#{new_resource.deploy_tag}" unless node.chef_environment !~ /^prod/

    # send word and notices that this actually did something
    Chef::Log.info("Initialized app #{new_resource.name}")
    new_resource.updated_by_last_action(true);

  else 

    # warn that the resource has already been set up
    Chef::Log.warn("App #{new_resource.name} is blocked from repeat installations")
    new_resource.updated_by_last_action(false);

  end

end

