## Cookbook Name:: radioedit
## Provider: node
##
## Copyright 2013, iHeartRadio
##
## All rights reserved - Do Not Redistribute
##
## authors:
## jderagon
##
## major refactor for han releaseo


## TODO: TREY:  need the following packages added to package.json
## 'jsdom'
## 'jquery'
## 'xmlhttprequest'


#
# Provider to setup a node app
# default provider -- expects to be passed the app name (currently app_api / app_auth)
#





# Create service init script for application.
# TODO

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
       # we need to do some more setting of variables based on which type of recipe we are calling
       # We can't just call these directly below because the variable exapnsion isn't working 
       # (double expansion such as:  node[:radioedit][#{app_name}][:repo] wasn't working)
       #
       case app_name
            when /app-script/
                app_repo =  node[:radioedit][:app_script][:repo]
                app_revision = node[:radioedit][:app_script][:deploy_revision] 
                app_workers = node[:radioedit][:app_script][:num_workers]
                #
                # TODO BAIL OUT ON BAD name
       end # case

      # Chef::Log.warn("DEPLOYING APP_NAME: #{app_name}");
      # Chef::Log.warn("DEPLOYING APP_USER: #{app_user}");
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

        application app_name do
          repository  "git@github.ihrint.com:radioedit/script-exec.git"
          revision  "master"
          path app_root
          owner app_user
          group app_user
          enable_submodules true
        end

        supervisor_service "app_script" do
          action [ :enable, :start ]
          autostart true
          autorestart true
          startretries 3
          startsecs 5
          stdout_logfile "#{node[:radioedit][:log_dir]}/#{app_name}.log"
          stderr_logfile "#{node[:radioedit][:log_dir]}/#{app_name}.err"
          directory "#{app_root}/current"
          user app_user
          environment node[:radioedit][:app_script][:environment]

          command "/usr/local/bin/node #{app_root}/current/runner.js"

        end

        # TODO Create service init script for application.

        # NPM
        # The built in NPM cookbook does not seem to support package.json so 
        # we have to do this through an "execute" directive.# TODO this should not run as root but NPM sort of sucks and tries 
        # to create /root/.npm for some stupid ass reason.
        execute "install_npm_requirements" do
          cwd "#{app_root}/current"
          user "root"
          command "npm config set ca null && npm install -g npm && npm install"
        end

        #
        # setup log rotate for the app we just setup
        # 

        node.tags << "radioedit.#{new_resource.name}"
        Chef::Log.info("Initialized app #{new_resource.name}")

    else 
       Chef::Log.info("App #{new_resource.name} has already been initialized")
    end
end


