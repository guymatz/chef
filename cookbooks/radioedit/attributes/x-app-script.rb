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
# @Changelog 3/13/14-GP: Split Script (script_exec) app configuration attributes into this file from default.rb 

# SCRIPT APPLICATION: attributes common to all environments
default[:radioedit][:app_script] = {
  # application name 
  :name                     => "app_script",
  # codebase git repo
  :repo                     => "git@github.ihrint.com:radioedit/script-exec.git",
  # chef tag to use for deployment flag
  :deploy_tag               => "radioedit.app_script.deployed",
  # default listen port
  :port                     => "/var/tmp/radioedit_script.sock",
  # application root directory
  :root_dir                 => "#{node[:radioedit][:path]}/app_script",
  # application owner username
  :user_name                => "ihr-deployer",

  # supervisor environment variables
  :environment => {
    # supervisor application process reference
    :RD_APP_NAME            => "app_script",    
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

    default[:radioedit][:app_script].merge!({
      # git tag/branch name
      :deploy_revision => "master",
      # webserver listen port
      :nginx_listen => 8080,
    });

    # merge in the supervisor configs
    default[:radioedit][:app_script][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "0",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit?replicaSet=Mongo-shared1",
      # elasticsearch uri
      :RD_ELASTICSEARCH_URI   => "http://localhost:9200/",
      # binary storage path uri
      :RD_STORAGE_MOUNTS      => "primary:/data/binstore",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN         => "",
      # access token (unknown)
      :RD_ACCESS_TOKEN        => "DjT5edoi7v",

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

    default[:radioedit][:app_script].merge!({
      # git tag/branch name
      :deploy_revision => "master",
      # webserver listen port
      :nginx_listen => 8080,
    });

    # # app specific settings, overrides for STAGE env
    # # APP_SCRIPT
    # default[:radioedit][:app_script][:deploy_revision] = "han"
    # default[:radioedit][:app_script][:branch] = "han"
    # default[:radioedit][:app_script][:env] = "ihr_testing"
    # default[:radioedit][:app_script][:statsd] = "iad-stg-stasd101-v700.ihr"
    # default[:radioedit][:app_script][:auth_uri] = "http://auth.dev.radioedit.ihr/auth"
    # default[:radioedit][:app_script][:api_uri] = "http://api.dev.radioedit.ihr/api/rpc"
    # default[:radioedit][:app_script][:service_uri] = "http://api.dev.radioedit.ihr/api/service"
    # default[:radioedit][:app_script][:storage_uri] = "http://api.dev.radioedit.ihr/storage"
    # default[:radioedit][:app_script][:statsd_prefix] = "radioedit"
    # default[:radioedit][:app_script][:elasticsearch_uri] = "127.0.0.1:9200"
    # default[:radioedit][:app_script][:auth_url] = "127.0.0.1:80"
    # default[:radioedit][:app_script][:sentry_dsn] = "null"
    # default[:radioedit][:app_script][:cdn_url] = "http://10.5.1.29/"

    # merge in the supervisor configs
    default[:radioedit][:app_script][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "0",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-logs?replicaSet=Mongo-shared-STG",
      # elasticsearch uri
      :RD_ELASTICSEARCH_URI   => "http://localhost:9200/",
      # binary storage path uri
      :RD_STORAGE_MOUNTS      => "primary:/data/binstore",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN         => "",
      # access token (unknown)
      :RD_ACCESS_TOKEN        => "DjT5edoi7v",

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
    
    default[:radioedit][:app_script].merge!({
      # git tag/branch name
      :deploy_revision => "master",
      # webserver listen port
      :nginx_listen => 8080,
    });

    # merge in the supervisor configs
    default[:radioedit][:app_script][:environment].merge!({
      # debug on(1)/off(0)
      :RD_DEBUG               => "0",
      # mongo cluster connection string
      :RD_MONGO_URI           => "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-logs?replicaSet=Mongo-shared-STG",
      # elasticsearch uri
      :RD_ELASTICSEARCH_URI   => "http://localhost:9200/",
      # binary storage path uri
      :RD_STORAGE_MOUNTS      => "primary:/data/binstore",
      # graphite statsd host
      :RD_STATSD              => "iad-stg-statsd101-v700.ihr",
      # remote sentry uri
      #:RD_SENTRY_DSN         => "",
      # access token (unknown)
      :RD_ACCESS_TOKEN        => "DjT5edoi7v",

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
    log "Warning: Chef environment ( #{chef_environment} ) Not supported by Radioedit Api Application" do
      level :warn 
    end

  # end Invalid environment

end  # end case chef_environment