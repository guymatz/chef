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
# authors:  jderagon, gpatmore
# 
#  Sun Feb 23 13:50:23 EST 2014
# 
#  Stub to setup the auth service
# @Changelog
#   - 3/17/14 GP
#     - adjusted to pass in all relevent settings to unicorn lwrp (pork barrel on OPS-6410 to make it easier to work with this stack)
#   
# ############################################################
## dev testing


if ( node.chef_environment =~ /^prod/ )
    #
    # call the provider for app-auth 
    #
    radioedit_unicorn "app_auth" do

        user "ihr-deployer"
        host "unix"
        port "/var/tmp/app_auth.sock"
        app_module "wsgi"
        webserver_listen 8080
        webserver_name "auth-int.radioedit.iheart.com auth.radioedit.iheart.com"
        log_level "ERROR"
        pid_file "var/run/radioedit/app_auth.pid"
        stdout_log "/var/log/radioedit/app_auth.out"
        stderr_log "/var/log/radioedit/app_auth.err"
        root_dir "/var/log/radioedit"
        venv_dir "/var/log/radioedit/env"
        src_dir "/var/log/radioedit/releases"
        repository "git@github.ihrint.com:radioedit/auth.git"
        revision "han"
        enable_submodules true
        workers 5        
        autostart true
        deploy_tag "radioedit.app_auth.deployed"

        environment node[:radioedit][:app_auth][:environment]

        # environment {
        #   # supervisor application process reference
        #   :RD_APP_NAME            => "app_auth",    
        #   # graphite stat prefix
        #   :RD_STATSD_PREFIX       => "radioedit",
        #   # debug on(1)/off(0)
        #   :RD_DEBUG               => "0",
        #   # mongo cluster connection string
        #   :RD_MONGO_URI           => "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit-auth?replicaSet=Mongo-shared1",
        #   # graphite statsd host
        #   :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
        #   # remote sentry uri
        #   :RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592",

        #   # #####################################
        #   # cross application uri
        #   # #####################################

        #   # internal paths
        #   :RD_AUTH_URI          => "http://auth-int.radioedit.iheart.com/auth",
        #   :RD_API_URI           => "http://api-int.radioedit.iheart.com/api/rpc",
        #   :RD_SERVICE_URI       => "http://api-int.radioedit.iheart.com/service",
        #   :RD_STORAGE_URI       => "http://api-int.radioedit.iheart.com/storage",
        #   :RD_SCRIPT_URI        => "http://script-int.radioedit.iheart.com",
        #   :RD_CDN_URI           => "http://radioedit-int.iheart.com",

        #   # external paths
        #   :RD_PUBLIC_AUTH_URI    => "http://auth.radioedit.iheart.com/auth",
        #   :RD_PUBLIC_API_URI     => "http://api.radioedit.iheart.com/api/rpc",
        #   :RD_PUBLIC_SERVICE_URI => "http://api.radioedit.iheart.com/service",
        #   :RD_PUBLIC_STORAGE_URI => "http://api.radioedit.iheart.com/storage",
        #   :RD_PUBLIC_SCRIPT_URI  => "http://script.radioedit.iheart.com",
        #   :RD_PUBLIC_CDN_URI     => "http://radioedit.iheart.com"

        # }

        not_if { node.chef_environment =~ /^prod/ && node.tags.include?("radioedit.app_auth.deployed") }

    end
else
    #
    # call the provider for app-auth 
    #
    radioedit_unicorn "app_auth" do

        user node[:radioedit][:app_auth][:user_name]
        host node[:radioedit][:app_auth][:host]
        port node[:radioedit][:app_auth][:port]
        app_module node[:radioedit][:app_auth][:module]
        webserver_listen node[:radioedit][:app_auth][:nginx_listen]
        webserver_name node[:radioedit][:app_auth][:webserver_name]
        log_level node[:radioedit][:app_auth][:log_level]
        pid_file node[:radioedit][:app_auth][:pid_file]
        stdout_log "#{node[:radioedit][:log_dir]}/app_auth.out"
        stderr_log "#{node[:radioedit][:log_dir]}/app_auth.err"
        root_dir node[:radioedit][:app_auth][:root_dir]
        venv_dir "#{node[:radioedit][:app_auth][:root_dir]}/env"
        src_dir "#{node[:radioedit][:app_auth][:root_dir]}/releases"
        repository node[:radioedit][:app_auth][:repo]
        revision node[:radioedit][:app_auth][:deploy_revision]
        enable_submodules true
        workers node[:radioedit][:app_auth][:num_workers]
        environment node[:radioedit][:app_auth][:environment]
        autostart true
        deploy_tag node[:radioedit][:app_auth][:deploy_tag]

        not_if { node.chef_environment =~ /^prod/ && node.tags.include?(node[:radioedit][:app_auth][:deploy_tag]) }

    end
end



