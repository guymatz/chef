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

    # ################################################################
    # Stage Environment settings.
    # ################################################################
    when /^stage/
    

        override[:memcached][:memory]  = 64;

        default[:radioedit][:statsd_host] = "iad-stg-statsd101-v700.ihr"

        default[:radioedit][:ldap_route] = {
          :network => "10.10.155.0/24",
          :gateway => "10.5.52.1"
        };


        #
        # varnish is the same for all apps
        #
        default[:radioedit][:varnish_backend_port] = "8080"
        default[:radioedit][:varnish_backend_ip] = "127.0.0.1"


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
