#
# Cookbook Name:: radioedit
# 
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# 
# authors:
# mrechler, gpatmore, jderagon
# 
# @Description major refactor for han release
# @Changelog 3/13/14-GP: Split Auth app configuration attributes into this file from default.rb 

# AUTH APPLICATION: attributes common to all environments
default[:radioedit][:app_auth] = {
  # application name 
  :name => "app_auth",
  # codebase git repo
  :repo => "git@github.ihrint.com:radioedit/auth.git",
  # chef tag to use for deployment flag
  :deploy_tag               => "radioedit.app_auth.deployed",
  # default listen port
  :port                     => "/var/tmp/radioedit_auth.sock",
  # application root directory
  :root_dir                 => "#{node[:radioedit][:path]}/app_auth",
  # application owner username
  :user_name                => "ihr-deployer",

  # supervisor environment variables
  :environment => {
    # supervisor application process reference
    :RD_APP_NAME            => "app_auth",    
    # graphite stat prefix
    :RD_STATSD_PREFIX       => "radioedit"
  }
};



# ################################################################
# Environment specific settings start here
# ################################################################
case chef_environment

  # ################################################################
  # PRODUCTION SETTINGS!!!!!
  # ################################################################
  when /^prod/

    default[:radioedit][:app_auth].merge!({
      # git tag/branch name
      :deploy_revision => "master",
      # webserver listen port
      :nginx_listen => 8080,
    });

     # merge in the supervisor configs
    default[:radioedit][:app_auth][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "0",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit?replicaSet=Mongo-shared1",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592"

      # #####################################
      # cross application uri
      # #####################################

      :RD_AUTH_URI            => "http://auth.radioedit-stg1-origin.ihrdev.com/auth/",
      :RD_API_URI             => "http://api.radioedit-stg1-origin.ihrdev.com/api/rpc",
      :RD_SERVICE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/service",
      :RD_STORAGE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/storage",
      :RD_SCRIPT_URI          => "http://script.radioedit-stg1-origin.ihrdev.com",
      :RD_CDN_URI             => "http://stage.radioedit.ihrdev.com/",
      :RD_PUBLIC_AUTH_URI     => "http://auth.stage.radioedit.ihrdev.com/auth/",
      :RD_PUBLIC_API_URI      => "http://api.stage.radioedit.ihrdev.com/api/rpc",
      :RD_PUBLIC_SERVICE_URI  => "http://api.stage.radioedit.ihrdev.com/service",
      :RD_PUBLIC_STORAGE_URI  => "http://api.stage.radioedit.ihrdev.com/storage",
      :RD_PUBLIC_SCRIPT_URI   => "http://script.stage.radioedit.ihrdev.com",
      :RD_PUBLIC_CDN_URI      => "http://stage.radioedit.ihrdev.com"

    });


  # END PRODUCTION SETTINGS

  # ################################################################
  # Stage Environment settings.
  # ################################################################
  when /^stage/

    default[:radioedit][:app_auth].merge!({
      # git tag/branch name
      :deploy_revision => "han",
      # webserver listen port
      :nginx_listen => 8080,
    });

    # # app specific settings, overrides for STAGE env
    # # APP_AUTH
    # default[:radioedit][:app_auth][:deploy_revision] = "han"
    # default[:radioedit][:app_auth][:branch] = "han"
    # default[:radioedit][:app_auth][:env] = "ihr_testing"
    # default[:radioedit][:app_auth][:statsd] = "iad-stg-stasd101-v700.ihr"
    # default[:radioedit][:app_auth][:statsd_prefix] = "radioedit"
    # default[:radioedit][:app_auth][:elasticsearch_uri] = "127.0.0.1:9200"
    # default[:radioedit][:app_auth][:auth_url] = "127.0.0.1:80"
    # default[:radioedit][:app_auth][:sentry_dsn] = "null"
    # default[:radioedit][:app_auth][:cdn_url] = "http://10.5.1.28/"
    # default[:radioedit][:app_auth][:port] = "8081"
    # default[:radioedit][:app_auth][:elastic_clustername] = "radioedit-staging";

     # merge in the supervisor configs
    default[:radioedit][:app_auth][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "1",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-auth?replicaSet=Mongo-shared-STG",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592"

      # #####################################
      # cross application uri
      # #####################################

      :RD_AUTH_URI            => "http://auth.radioedit-stg1-origin.ihrdev.com/auth/",
      :RD_API_URI             => "http://api.radioedit-stg1-origin.ihrdev.com/api/rpc",
      :RD_SERVICE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/service",
      :RD_STORAGE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/storage",
      :RD_SCRIPT_URI          => "http://script.radioedit-stg1-origin.ihrdev.com",
      :RD_CDN_URI             => "http://stage.radioedit.ihrdev.com/",
      :RD_PUBLIC_AUTH_URI     => "http://auth.stage.radioedit.ihrdev.com/auth/",
      :RD_PUBLIC_API_URI      => "http://api.stage.radioedit.ihrdev.com/api/rpc",
      :RD_PUBLIC_SERVICE_URI  => "http://api.stage.radioedit.ihrdev.com/service",
      :RD_PUBLIC_STORAGE_URI  => "http://api.stage.radioedit.ihrdev.com/storage",
      :RD_PUBLIC_SCRIPT_URI   => "http://script.stage.radioedit.ihrdev.com",
      :RD_PUBLIC_CDN_URI      => "http://stage.radioedit.ihrdev.com"

    });

  # END STAGE SETTINGS

  # ################################################################
  # Development Environment settings.
  # ################################################################
  when /^dev/

    default[:radioedit][:app_auth].merge!({
      # git tag/branch name
      :deploy_revision => "han",
      # webserver listen port
      :nginx_listen => 8080,
    });

     # merge in the supervisor configs
    default[:radioedit][:app_auth][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "1",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-logs?replicaSet=Mongo-shared-STG",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592"

      # #####################################
      # cross application uri
      # #####################################

      :RD_AUTH_URI            => "http://auth.radioedit-stg1-origin.ihrdev.com/auth/",
      :RD_API_URI             => "http://api.radioedit-stg1-origin.ihrdev.com/api/rpc",
      :RD_SERVICE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/service",
      :RD_STORAGE_URI         => "http://api.radioedit-stg1-origin.ihrdev.com/storage",
      :RD_SCRIPT_URI          => "http://script.radioedit-stg1-origin.ihrdev.com",
      :RD_CDN_URI             => "http://stage.radioedit.ihrdev.com/",
      :RD_PUBLIC_AUTH_URI     => "http://auth.stage.radioedit.ihrdev.com/auth/",
      :RD_PUBLIC_API_URI      => "http://api.stage.radioedit.ihrdev.com/api/rpc",
      :RD_PUBLIC_SERVICE_URI  => "http://api.stage.radioedit.ihrdev.com/service",
      :RD_PUBLIC_STORAGE_URI  => "http://api.stage.radioedit.ihrdev.com/storage",
      :RD_PUBLIC_SCRIPT_URI   => "http://script.stage.radioedit.ihrdev.com",
      :RD_PUBLIC_CDN_URI      => "http://stage.radioedit.ihrdev.com"

    });
    
  # END DEVELOPMENT SETTINGS

  # ################################################################
  # Invalid environment
  # ################################################################
  else

    # can't abort, so warn and check in recipes depending on attrib defs from here.
      log "Warning: Chef environment ( #{chef_environment} ) Not supported by Radioedit Authentication Application" do
        level :warn 
      end

  # end Invalid environment

end  # end case chef_environment