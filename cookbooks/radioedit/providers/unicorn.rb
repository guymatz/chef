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
    unless node.tags.include? "radioedit.#{new_resource.name}"
      Chef::Log.info("Bootstrapping app #{new_resource.name}")

      #
      # this is where we set some temp variables as it is easier than
      # if we keep having to reference node / defaults.   
      # we shouldn't be overriding anything here, the place to override app defaults
      # is under the specific stage settings in attributes/default.rb
      #
      log_level = @new_resource.log_level
      pid_file = @new_resource.pid_file
      out_log =  @new_resource.out_log
      err_log =  @new_resource.err_log
      @new_resource.root_dir = @new_resource.root_dir
      env_path = @new_resource.env_dir || "#{@new_resource.root_dir}/env"
      src_path = @new_resource.src_dir || "#{@new_resource.root_dir}/releases"
      app_repo =  @new_resource.repository
      app_revision = @new_resource.revision
      app_workers = @new_resource.workers
      app_env = @new_resource.environment_name
      env_vars = @new_resource.env_vars

      #
      # Create directories for application
      #
      [ @new_resource.root_dir, @new_resource.env_dir, @new_resource.src_dir ].each do |d|
          directory d do
            owner @new_resource.user
            group @new_resource.user
          end
      end # directories

        
      #
      # set up the actual application and gunicorn
      #
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

        #
        # install pip requirements
        #
#        execute "install_requirements" do
#            cwd @new_resource.root_dir
#            user @new_resource.user
#            command "#{env_path}/bin/pip install -r #{@new_resource.root_dir}/current/requirements.txt"
#        end

        #
        # Nginx Config
        #
        template "/etc/nginx/conf.d/#{new_resource.name}.conf" do
          source "nginx-#{new_resource.name}.conf.erb"
          owner "root"
          group "root"
          mode 0600
          variables({
              :app_name =>            @new_resource.name,
              :legacy_static_root =>  node[:radioedit][:legacy_static_root],
              :webserver_port =>      node[:radioedit]["#{new_resource.name}"][:nginx_listen],
          })
            
        end

        # Create service init script for application.
        template "/etc/init/#{new_resource.name}.conf" do
            source "radioedit-initd.sh.erb"
            owner "root"
            group "root"
        end

        #
        # setup log rotate for the app we just setup
        # 
        logrotate_app "#{new_resource.name}.out" do
          cookbook "logrotate"
          path out_log
          options ["missingok", "compress", "notifempty", "sharedscripts","dateext"]
          frequency "daily"
          enable true
          rotate 5
          size "2G"
          postrotate ' [ -f #{pid_file}] && kill -USR1 `cat #{pid_file}`'
        end

        logrotate_app "#{new_resource.name}.err" do
          cookbook "logrotate"
          path err_log
          options ["missingok", "compress", "notifempty", "sharedscripts","dateext"]
          frequency "daily"
          enable true
          rotate 5
          size "2G"
          postrotate ' [ -f #{pid_file}] && kill -USR1 `cat #{pid_file}`'
        end


        node.tags << "radioedit.#{new_resource.name}"
        Chef::Log.info("Initialized app #{new_resource.name}")

    else 
       Chef::Log.info("App #{new_resource.name} has already been initialized")
    end
end

