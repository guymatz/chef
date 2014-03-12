#
# Cookbook Name:: radioedit
# 
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute
# 
# authors:
# mrechler, gpattmore, jderagon
# 
# major refactor for han release


default[:radioedit] = {
  # legacy default user for owning radioedit platforms/deploys
  :user           => 'ihr-deployer',
};

#
# Requirements for core system
#
default[:radioedit] = {
  :packages     => %w{ 
    freetype
    freetype-devel
    gcc
    gcc-c++
    git
    lcms
    lcms-devel
    libevent
    libevent-devel
    libjpeg
    libjpeg-devel
    libnih
    libnih-devel
    libtiff
    libtiff-devel
    libvmod
    libvmod-statsd
    libwebp
    libxml2
    libxml2-devel
    libxslt
    libxslt-devel
    memcached
    libmemcached
    libmemcached-devel
    nginx
    openldap
    openldap-devel
    openssl
    openssl-devel
    patch
    postgresql-devel
    python27
    python27-devel
    python27-libs
    python27-test
    python27-tools
    python-devel
    python-ldap
    python-setuptools
    python-virtualenv
    readline-devel
    varnish
    zlib
    zlib-devel
  }
};

#
# directory paths shared through all envs
#
#
default[:radioedit][:req_dirs] = %w{
    /data
    /data/apps
    /data/apps/radioedit
    /data/apps/binstore
    /data/legacy
    /data/legacy/p4
    /var/run/radioedit
    /var/log/radioedit
};


#
# Global app root for all apps
# 
default[:radioedit][:app_root] = "/data/apps"
default[:radioedit][:legacy_root] = "/data/legacy/p4"
#
# path and logging settings
# shared amongst all envs currently
#
default[:radioedit][:path] = "#{default[:radioedit][:app_root]}/radioedit"
default[:radioedit][:app_user] = "ihr-deployer"
default[:radioedit][:log_dir] = "/var/log/radioedit"
default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
default[:radioedit][:asset_dir] = "/data/binstore/assets"

default[:radioedit][:host] = "unix"



# App Specific Configuration.
default[:radioedit][:app_api] = {
  :name => "radioedit-api",
  :repo => "git@github.ihrint.com:radioedit/core.git",
  :deploy_revision => "master", # changes based on env
  :nginx_listen => 8080,
  :environment => {
    :RD_APP_NAME =>           "app_api",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit?replicaSet=Mongo-shared-STG",
    :RD_ELASTICSEARCH_URI =>  "http://localhost:9200/",
    :RD_CDN_URI =>            "http://api.stage.radioedit.ihr/",
    :RD_AUTH_URI =>           "http://auth.stage.radioedit.ihr/auth",
    :RD_API_URI =>            "http://api.stage.radioedit.ihr/api/rpc",
    :RD_SCRIPT_URI =>         "http://script.stage.radioedit.ihr/",
    :RD_STORAGE_URI =>        "http://api.stage.radioedit.ihr/storage",
    :RD_SERVICE_URI =>        "http://api.stage.radioedit.ihr/service",
    :RD_STORAGE_MOUNTS =>     "primary:/data/binstore",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_STATSD_PREFIX =>      "radioedit",
    #:RD_SENTRY_DSN =>         "https://c3c60ffdb0354f38ada11c9cff9be827:0bad13885cfb4024854075c58ff53295@app.getsentry.com/11937"
  }
};


# App Specific Configuration.
default[:radioedit][:app_auth] = {
  :name => "radioedit-auth",
  :repo => "git@github.ihrint.com:radioedit/auth.git",
  :deploy_revision => "master", # changes based on env
  :nginx_listen => 8080,
  :environment => {
    :RD_APP_NAME =>           "app_auth",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-auth?replicaSet=Mongo-shared-STG",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_STATSD_PREFIX =>      "radioedit",
    #:RD_SENTRY_DSN =>         "https://5a99baf425954927b38c9c7373502abf:e86faffebc4e4a9f854e0fedfd2a585a@app.getsentry.com/18592"
  }
};

# App Specific Configuration.
default[:radioedit][:app_script] = {
  :name => "radioedit-script",
  :repo => "git@github.ihrint.com:radioedit/script-exec.git",
  :nginx_listen => 8080,
  :deploy_revision => "master",
  :environment => {
    :RD_APP_NAME =>           "app_script",
    :RD_DEBUG =>              "1",
    :RD_MONGO_URI =>          "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018/radioedit-logs?replicaSet=Mongo-shared-STG",
    :RD_CDN_URI =>            "http://api.stage.radioedit.ihr/",
    :RD_AUTH_URI =>           "http://auth.stage.radioedit.ihr/auth",
    :RD_STORAGE_URI =>        "http://api.stage.radioedit.ihr/storage",
    :RD_API_URI =>            "http://api.stage.radioedit.ihr/api/rpc",
    :RD_SERVICE_URI =>        "http://api.stage.radioedit.ihr/api/service",
    :RD_STATSD_PREFIX =>      "radioedit",
    :RD_ELASTICSEARCH_URI =>  "http://localhost:9200/",
    :RD_STATSD =>             "iad-stg-statsd101-v700.ihr",
    :RD_ACCESS_TOKEN =>       "DjT5edoi7v"
    #:RD_SENTRY_DSN =>         "https://c3c60ffdb0354f38ada11c9cff9be827:0bad13885cfb4024854075c58ff53295@app.getsentry.com/11937"
  }
}


# ################################################################
# Environment specific settings start here
# ################################################################
case chef_environment


    # ################################################################
    # PRODUCTION SETTINGS!!!!!
    # ################################################################
    when /^prod/

      override[:memcached][:memory]  = 64;

      # log verbosity
      default[:radioedit][:log_level] = "WARNING"
      # github settings
      default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
      default[:radioedit][:branch] = "ganon.3"
      default[:radioedit][:env] = "ihr_testing"

      # deployment tag
      default[:radioedit][:deploy_tag] = "radioedit-deployed"

      # cdn settings
      default[:radioedit][:cdn_url] = "http://imgproxy.iheart.com/"
      default[:radioedit][:nfs_server] = "iad-nfs101-v200.ihr"
      default[:radioedit][:nfs_remdir] = "/data/imgscaler/radioedit"
      default[:radioedit][:nfs_locdir] = "/data/binstore"

      # port and worker settings
      default[:radioedit][:module] = "wsgi:application"
      default[:radioedit][:app_name] = "radioedit-core"
      default[:radioedit][:num_workers] = 5
      default[:radioedit][:port] = "/var/tmp/radioedit-cms.sock"
      default[:radioedit][:listen] = "/var/tmp/radioedit-cms.sock"
      default[:radioedit][:host] = "unix"

      # db settings
      default[:radioedit][:mongo_cstring] = "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit?replicaSet=Mongo-shared1"

      # varnish / elastic settings
      default[:radioedit][:elastic_clustername] = "radioedit"
      default[:radioedit][:varnish_backend_port] = "8080"
      default[:radioedit][:varnish_backend_ip] = "127.0.0.1"


    # END PRODUCTION SETTINGS

    when /^stage-jd/
    # ################################################################
    # Stage Environment settings.
    # ################################################################

        override[:memcached][:memory]  = 64;

        default[:radioedit][:statsd_host] = "iad-stg-statsd101-v700.ihr"

        default[:radioedit][:ldap_route] = {
          :network => "10.10.155.0/24",
          :gateway => "10.5.52.1"
        };

        # app specific settings, overrides for STAGE env
        # APP_API
        default[:radioedit][:app_api][:deploy_revision] = "master"
        default[:radioedit][:app_api][:branch] = "master"
        default[:radioedit][:app_api][:env] = "ihr_testing"
        default[:radioedit][:app_api][:statsd] = "iad-stg-stasd101-v700.ihr"
        default[:radioedit][:app_api][:statsd_prefix] = "radioedit"
        default[:radioedit][:app_api][:elasticsearch_uri] = "127.0.0.1:9200"
        default[:radioedit][:app_api][:auth_url] = "127.0.0.1:80"
        default[:radioedit][:app_api][:sentry_dsn] = "null"
        default[:radioedit][:app_api][:cdn_url] = "http://10.5.1.28/"
        default[:radioedit][:app_api][:port] = "8080"
        default[:radioedit][:app_api][:elastic_clustername] = "radioedit-staging";
        default[:radioedit][:app_api][:staticdir] = "#{default[:radioedit][:path]}/app_api/static"

        # app specific settings, overrides for STAGE env
        # APP_AUTH
        default[:radioedit][:app_auth][:deploy_revision] = "master"
        default[:radioedit][:app_auth][:branch] = "master"
        default[:radioedit][:app_auth][:env] = "ihr_testing"
        default[:radioedit][:app_auth][:statsd] = "iad-stg-stasd101-v700.ihr"
        default[:radioedit][:app_auth][:statsd_prefix] = "radioedit"
        default[:radioedit][:app_auth][:elasticsearch_uri] = "127.0.0.1:9200"
        default[:radioedit][:app_auth][:auth_url] = "127.0.0.1:80"
        default[:radioedit][:app_auth][:sentry_dsn] = "null"
        default[:radioedit][:app_auth][:cdn_url] = "http://10.5.1.28/"
        default[:radioedit][:app_auth][:port] = "8081"
        default[:radioedit][:app_auth][:elastic_clustername] = "radioedit-staging";

        # app specific settings, overrides for STAGE env
        # APP_SCRIPT
        default[:radioedit][:app_script][:deploy_revision] = "master"
        default[:radioedit][:app_script][:branch] = "master"
        default[:radioedit][:app_script][:env] = "ihr_testing"
        default[:radioedit][:app_script][:statsd] = "iad-stg-stasd101-v700.ihr"
        default[:radioedit][:app_script][:auth_uri] = "http://auth.dev.radioedit.ihr/auth"
        default[:radioedit][:app_script][:api_uri] = "http://api.dev.radioedit.ihr/api/rpc"
        default[:radioedit][:app_script][:service_uri] = "http://api.dev.radioedit.ihr/api/service"
        default[:radioedit][:app_script][:storage_uri] = "http://api.dev.radioedit.ihr/storage"
        default[:radioedit][:app_script][:statsd_prefix] = "radioedit"
        default[:radioedit][:app_script][:elasticsearch_uri] = "127.0.0.1:9200"
        default[:radioedit][:app_script][:auth_url] = "127.0.0.1:80"
        default[:radioedit][:app_script][:sentry_dsn] = "null"
        default[:radioedit][:app_script][:cdn_url] = "http://10.5.1.29/"

        #
        # log verbosity
        #
        default[:radioedit][:app_api][:log_level] = "DEBUG"

        #
        # varnish is the same for all apps
        #
        default[:radioedit][:varnish_backend_port] = "8080"
        default[:radioedit][:varnish_backend_ip] = "127.0.0.1"

        #
        # port and worker settings
        default[:radioedit][:app_api][:num_workers] = 5


# TODO      default[:radioedit][:nfs_server] = "iad-nfs101-v200.ihr"
# TODO     default[:radioedit][:nfs_remdir] = "/data/imgscaler/radioedit"
# TODO    default[:radioedit][:nfs_locdir] = "/data/binstore"




# End of stage settings

        else # development fallthrough
# ################################################################
# Development Environment settings.
# ################################################################

        override[:memcached][:memory]  = 64;
# 
# deployment tag
#
        default[:radioedit][:deploy_tag] = "radioedit-deployed"

#
# log verbosity
#
        default[:radioedit][:log_level] = "DEBUG"

#
# github settings
#
        default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
        default[:radioedit][:branch] = "release"
        default[:radioedit][:intbranch] = "testing"
        default[:radioedit][:env] = "ihr_testing"

#
# port and worker settings
#
        default[:radioedit][:module] = "wsgi:application"
        default[:radioedit][:app_name] = "radioedit-core"
        default[:radioedit][:num_workers] = 5
        default[:radioedit][:port] = "/var/tmp/radioedit-cms.sock"
        default[:radioedit][:listen] = "/var/tmp/radioedit-cms.sock"
        default[:radioedit][:host] = "unix"

        default[:radioedit][:module] = "wsgi"

        default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
        default[:radioedit][:asset_dir] = "/data/binstore"

        default[:radioedit][:cdn_url] = "http://10.5.1.29/"
#
# db settings
#
        default[:radioedit][:mongo_cstring] = "mongodb://use1b-radioedit-test102.ihr:37017,use1b-radioedit-test103.ihr:37017,use1b-radioedit-test104.ihr:37017/radioedit-f?replicaSet=RadioEdit1"

      #
      # varnish / elastic settings
      #
      default[:radioedit][:elastic_clustername] = "radioedit-dev";
# should this be 80 or 8080?
      default[:radioedit][:varnish_backend_port] = "8080"
      default[:radioedit][:varnish_backend_ip] = "127.0.0.1"
  
    # END Development env settings.
end  # env switch

### 
###
###

# ################################################################
# Platform Release specific  settings.
# ################################################################
default[:radioedit][:image] = {
  :path         => "/data/apps/radioedit/images",
  :branch       => "deploy",
  :repo         => "git@github.com:iheartradio/radioedit-img.git",
  :port         => 8000,
  :listen       => "/var/tmp/radioedit-image.sock",
  :packages     => %w{ 
      python-imaging 
      python-psycopg2 
      postgresql-libs 
  }
};


# should be depreciated soon - hopefully
default[:radioedit][:cms] = {
  :path         => "/data/apps/radioedit/radioedit-core",
  :repo         => "git@github.com:iheartradio/featcontent.git",
  :branch       => node.run_list.include?('role[radioedit_server_a]') ? 'deploy_a_release' : 'deploy',
  :packages     => %w{ python-psycopg2 postgresql-libs libjpeg-devel },
  :port         => "/var/tmp/radioedit-cms.sock",
  :listen       => "/var/tmp/radioedit-cms.sock",
  :host         => "unix",
  :static       => node.run_list.include?('role[radioedit_server_a]') ? 'staticv1' : 'static'
};
