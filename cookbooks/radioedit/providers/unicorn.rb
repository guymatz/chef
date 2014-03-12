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
        app_name = "#{new_resource.name}"
        app_user = "#{node[:radioedit][:app_user]}"
        app_port = "/var/tmp/radioedit-#{app_name}.sock"
        log_level = "DEBUG"
#        log_level =  "#{[:radioedit][#{app_name}][:log_level]}"
        pid_file = "/var/run/radioedit-#{app_name}.pid"
        app_listen = "/var/tmp/radioedit-#{app_name}.sock"
        out_log =  "#{node[:radioedit][:log_dir]}/#{app_name}_error.log"
        err_log =  "#{node[:radioedit][:log_dir]}/#{app_name}_error.log"
        app_root = "/data/apps/radioedit/#{app_name}"
        env_path = "#{app_root}/env"
        src_path = "#{app_root}/releases"

        #
        # Create directories for application
        #
        [app_root, env_path, src_path].each do |d|
            directory d do
              owner app_user
              group app_user
            end
        end # directories

        #
        # setup virtual env #TODO JPD I DON"T KNOW IF THIS ACTUALLY WORKS
        #
#        python_virtualenv env_path do
#            interpreter "python27"
#            owner app_user
#            group app_user
#            options "--distribute"
#            action :create
#        end # virtualenv

       #
       # we need to do some more setting of variables based on which type of recipe we are calling
       # We can't just call these directly below because the variable exapnsion isn't working 
       # (double expansion such as:  node[:radioedit][#{app_name}][:repo] wasn't working)
       #
       case app_name
        when /app_api/
            app_repo =  node[:radioedit][:app_api][:repo]
            app_revision = node[:radioedit][:app_api][:deploy_revision] 
            app_workers = node[:radioedit][:app_api][:num_workers]

            app_env = node[:radioedit][:app_api][:environment]
            app_mongo = node[:radioedit][:app_api][:environment][:RD_MONGO_URI]

            Chef::Log.warn("DUMPING ENV VARS: #{node[:radioedit][:app_api]}")
            Chef::Log.warn("DUMPING ENV VARS (alias): #{app_env}")

        when /app_auth/
            app_repo =  node[:radioedit][:app_auth][:repo]
            app_revision = node[:radioedit][:app_auth][:deploy_revision] 
            app_workers = node[:radioedit][:app_auth][:num_workers]

            app_env = node[:radioedit][:app_auth][:environment]

       end # case

       # template "#{app_root}/current/settings.json" do
       #   source "stage-settings.json.erb"
       #   owner app_user
       #   group app_user
       #      variables({
       #          # TODO put variables for this file. jpd
       #      })
       #  end

       # link "#{app_root}/shared/settings.json" do
       #   to "#{app_root}/current/settings.json"
       #   action :create
       #   owner app_user
       #   group app_user
       #   not_if "test -L #{app_root}/shared/settings.json"
       # end

      # Chef::Log.warn("DEPLOYING APP_NAME: #{app_name}");
      # Chef::Log.warn("DEPLOYING APP_USER: #{app_user}");
      # Chef::Log.warn("DEPLOYING APP_PORT: #{app_port}");
      # Chef::Log.warn("DEPLOYING LOG_LEVEL: #{log_level}");
      # Chef::Log.warn("DEPLOYING PID_FILE: #{pid_file}");
      # Chef::Log.warn("DEPLOYING APP_LISTEN: #{app_listen}");
      # Chef::Log.warn("DEPLOYING OUT_LOG: #{out_log}");
      # Chef::Log.warn("DEPLOYING ERR_LOG: #{err_log}");
      # Chef::Log.warn("DEPLOYING APP_ROOT: #{app_root}");
      # Chef::Log.warn("DEPLOYING ENV_PATH: #{env_path}");
      # Chef::Log.warn("DEPLOYING SRC_PATH: #{src_path}");
      # Chef::Log.warn("DEPLOYING APP_REPO: #{app_repo}");
      # Chef::Log.warn("DEPLOYING APP_REV: #{app_revision}");
      # Chef::Log.warn("DEPLOYING APP_WORKERS: #{app_workers}");
      # Chef::Log.warn("DEPLOYING ENV_VARS: #{app_env}");
      # Chef::Log.warn("DEPLOYING NUM_ENV_VARS: #{app_env.length}");

        
        #
        # set up the actual application and gunicorn
        #
        application app_name do
            repository app_repo
            revision app_revision
            path app_root
            owner app_user
            group app_user
            enable_submodules true

            gunicorn do
              app_module "wsgi"
              settings_template "re-gunicorn.py.erb"
              port app_port
              host node[:radioedit][:host]
              workers app_workers
              pidfile pid_file
              stdout_logfile out_log
              stderr_logfile err_log
              loglevel log_level
              interpreter "python27"
              requirements "requirements.txt"
              autostart true
              virtualenv env_path
              environment app_env
            end # gunicorn
            
        end # application

        #
        # install pip requirements
        #
#        execute "install_requirements" do
#            cwd app_root
#            user app_user
#            command "#{env_path}/bin/pip install -r #{app_root}/current/requirements.txt"
#        end

        #
        # Nginx Config
        #
        template "/etc/nginx/conf.d/#{app_name}.conf" do
          source "nginx-#{app_name}.conf.erb"
          owner "root"
          group "root"
          mode 0600
          variables({
              :app_name =>            app_name,
              :legacy_static_root =>  node[:radioedit][:legacy_static_root],
              :webserver_port =>      node[:radioedit]["#{app_name}"][:nginx_listen],
          })
            
        end

        # Create service init script for application.
        template "/etc/init/#{app_name}.conf" do
            source "radioedit-initd.sh.erb"
            owner "root"
            group "root"
        end

        #
        # setup log rotate for the app we just setup
        # 
        logrotate_app "#{app_name}.out" do
          cookbook "logrotate"
          path out_log
          options ["missingok", "compress", "notifempty", "sharedscripts","dateext"]
          frequency "daily"
          enable true
          rotate 5
          size "2G"
          postrotate ' [ -f #{pid_file}] && kill -USR1 `cat #{pid_file}`'
        end

        logrotate_app "#{app_name}.err" do
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

