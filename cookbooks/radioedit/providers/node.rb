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

  new_resource = @new_resource

  unless node.tags.include? "#{new_resource.deploy_tag}" && node.chef_environment !~ /^prod/

    Chef::Log.info("Bootstrapping app #{new_resource.name}")

    # Create directories for application (app home, venv dir, and deployment release directory)
    [ new_resource.root_dir, new_resource.venv_dir, new_resource.src_dir ].each do |d|

      directory d do
        owner new_resource.user
        group new_resource.user
      end

    end # directories

    # touch the log files to make sure they have the proper perms
    # also can set up the log rotation
    [ new_resource.stdout_log, new_resource.stderr_log ].uniq.each do |f|

      file f do
        owner new_resource.user
        group new_resource.user
        mode "0755"
        action :touch
      end

      logrotate_app "#{new_resource.name}.out" do
        cookbook "logrotate"
        path f
        frequency "daily"
        enable true
        rotate 5
        size "2G"
        options %w{ missingok compress notifempty sharedscripts dateext }
        postrotate "[ -f #{new_resource.pid_file}] && kill -USR1 `cat #{new_resource.pid_file}`"
      end

    end

    # set up the actual application 
    application "#{new_resource.name}" do
      repository new_resource.repository
      revision new_resource.revision
      path new_resource.root_dir
      owner new_resource.user      
      group new_resource.user
      enable_submodules new_resource.enable_submodules
    end

    # set up the supervisor process monitoring
    supervisor_service "#{new_resource.name}" do      
      autostart new_resource.autostart
      autorestart new_resource.autostart
      startretries 3
      startsecs 5
      stdout_logfile new_resource.stdout_log
      stderr_logfile new_resource.stderr_log
      directory "#{new_resource.root_dir}/current"
      user new_resource.user
      environment new_resource.environment
      command "/usr/local/bin/node #{new_resource.root_dir}/current/runner.js"

      action [ :enable, :start ]

    end

      # @TODO Create service init script for application.

      # NPM
      # The built in NPM cookbook does not seem to support package.json so 
      # we have to do this through an "execute" directive.# TODO this should not run as root but NPM sort of sucks and tries 
      # to create /root/.npm for some stupid ass reason.
      execute "install_npm_requirements" do
        cwd "#{new_resource.root_dir}/current"
        user "root"
        command "npm config set ca null && npm install -g npm && npm install"
      end


    node.tags << "#{new_resource.deploy_tag}" unless node.chef_environment !~ /^prod/


     # send word and notices that this actually did something
    Chef::Log.info("Initialized app #{new_resource.name}")
    new_resource.updated_by_last_action(true);

  else

    # warn that the resource has already been set up
    Chef::Log.warn("App #{new_resource.name} is blocked from repeat installations")
    new_resource.updated_by_last_action(false);

  end
end


