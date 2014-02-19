#
# Cookbook Name:: radioedit
# 
# Copyright 2013, iHeartRadio
#
# All rights reserved - Do Not Redistribute

default[:radioedit] = {
  # legacy default user for owning radioedit platforms/deploys
  :user           => 'ihr-deployer',
  # Im not sure what this was used for
  :zeromq         => {:repo_url => ''},
  # Path that needs to get traced for attribute use. this might be an orphan
  :install_path   => "/data/apps/radioedit",
  # Again, another possible orphan
  :nginx          => {:port => 8000},

  # user shell account management
  :user_accounts  => {

    # user accounts for the development team
    :devteam  => %w{
      tlong
      tterry
    },

    # user accounts for the dba team
    :dbteam   => %w{
      ikaprizkina
    }
  }

};


# Requirements
default[:radioedit][:core] = {
  :packages     => %w{ 
    python27 
    python27-libs 
    python27-devel 
    python27-test 
    python27-tools 
    nginx 
    zlib-devel 
    libjpeg 
    zlib 
    gcc 
    python-devel 
    git 
    libevent-devel 
    libevent 
    zeromq-devel 
    zeromq 
    python-setuptools 
    python-ldap 
    postgresql-devel 
    openldap-devel 
    varnish 
    readline-devel 
    patch 
    libjpeg-devel 
  },

  :pips         => %w{ 
    supervisor 
    pymongo 
    python-memcached 
    gunicorn 
    greenlet 
    statsd 
    pyzmq 
  }
};

default[:radioedit][:diablocore][:packages] = %w{ 
  nginx 
  zlib-devel 
  libjpeg 
  zlib 
  gcc 
  python-devel 
  git 
  libevent-devel 
  libevent 
  zeromq-devel 
  zeromq 
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

  default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
  default[:radioedit][:branch] = "ganon.3"
  default[:radioedit][:env] = "ihr_testing"
  default[:radioedit][:app_user] = "ihr-deployer"
  default[:radioedit][:path] = "/data/apps/radioedit"
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-core.pid"
  default[:radioedit][:log_dir] = "/var/log/radioedit"
  default[:radioedit][:out_log] = "#{default[:radioedit][:log_dir]}/application.log"
  default[:radioedit][:err_log] = "#{default[:radioedit][:log_dir]}/application.err"
  default[:radioedit][:venv_path] = "#{default[:radioedit][:path]}/envs/core"
  default[:radioedit][:module] = "wsgi:application"
  default[:radioedit][:app_name] = "radioedit-core"
  default[:radioedit][:num_workers] = 5
  default[:radioedit][:log_level] = "WARNING"
  default[:radioedit][:port] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:listen] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:host] = "unix"
  default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
  default[:radioedit][:staticdir] = "#{default[:radioedit][:path]}/static"
  default[:radioedit][:asset_dir] = "/data/binstore/assets"
  default[:radioedit][:cdn_url] = "http://imgproxy.iheart.com/"
  default[:radioedit][:mongo_cstring] = "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit?replicaSet=Mongo-shared1"
  default[:radioedit][:nfs_server] = "10.5.40.121"
  default[:radioedit][:nfs_remdir] = "/data/imgscaler/radioedit"
  default[:radioedit][:nfs_locdir] = "/data/binstore"
  default[:radioedit][:elastic_clustername] = "radioedit"
  default[:radioedit][:deploy_tag] = "radioedit-deployed"
  default[:radioedit][:varnish_backend_port] = "8080"
  default[:radioedit][:varnish_backend_ip] = "127.0.0.1"
  default[:radioedit][:req_dirs] = %w{ 
    /data 
    /data/apps 
    /data/apps/radioedit 
    /data/apps/radioedit/util 
    /data/apps/radioedit/static
    /data/apps/radioedit/releases 
    /data/apps/radioedit/envs 
    /data/apps/radioedit/envs/core 
    /var/run/radioedit 
    /var/log/radioedit 
    /data/apps/radioedit/shared 
  };

  default[:radioedit][:packages] = %w{ 
    libevent 
    memcached 
    python27 
    python27-libs 
    python27-devel 
    python27-test 
    python27-tools 
    nginx 
    zlib-devel 
    openjpeg-devel 
    zlib 
    gcc 
    python-devel 
    git 
    libevent-devel 
    zeromq-devel 
    zeromq 
    python-setuptools 
    python-ldap 
    postgresql-devel 
    openldap-devel 
    varnish 
    readline-devel 
    patch 
    libjpeg-devel
    nginx
    rsyslog
    libxml2-devel
    libxslt-devel
  };

  default[:radioedit][:pips] = %w{ 
    lxml
    supervisor 
    pymongo 
    python-memcached 
    greenlet 
    statsd 
    pyzmq 
    flask 
    flask-cache 
    flask-pymongo 
    pillow 
    blinker 
    celery 
    colorama 
    docutils 
    gevent-websocket 
    jsonschema 
    mock 
    pql 
    pyparsing 
    python-dateutil 
    python-ldap 
    requests 
    simplejson 
    raven 
    pytest 
  };
# END PRODUCTION SETTINGS

# ################################################################
# Stage Environment settings.
# ################################################################
when /^stage/

  override[:memcached][:memory]  = 64;

  default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
  default[:radioedit][:branch] = "staging"
  default[:radioedit][:env] = "ihr_testing"
  default[:radioedit][:path] = "/data/apps/radioedit";
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-core.pid"
  default[:radioedit][:log_dir] = "/var/log/radioedit"
  default[:radioedit][:out_log] = "#{default[:radioedit][:log_dir]}/application.log"
  default[:radioedit][:err_log] = "#{default[:radioedit][:log_dir]}/application.err"
  default[:radioedit][:venv_path] = "#{default[:radioedit][:path]}/envs/core";
  default[:radioedit][:module] = "wsgi:application"
  default[:radioedit][:app_name] = "radioedit-core"
  default[:radioedit][:num_workers] = 5
  default[:radioedit][:log_level] = "DEBUG"
  default[:radioedit][:varnish_backend_port] = "8080"
  default[:radioedit][:varnish_backend_ip] = "127.0.0.1"
  default[:radioedit][:port] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:listen] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:host] = "unix"
  default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
  default[:radioedit][:staticdir] = "#{default[:radioedit][:path]}/static"
  default[:radioedit][:asset_dir] = "/data/binstore"
  default[:radioedit][:cdn_url] = "http://10.5.1.28/"
  default[:radioedit][:elastic_clustername] = "radioedit-staging";
  default[:radioedit][:mongo_cstring] = "mongodb://iad-stg-mongo-fac101-v760.ihr:37018,iad-stg-mongo-fac102-v760.ihr:37018"
  default[:radioedit][:req_dirs] = %w{ 
    /data 
    /data/binstore
    /data/apps
    /data/apps/radioedit 
    /data/apps/radioedit/util 
    /data/apps/radioedit/static
    /data/apps/radioedit/releases 
    /data/apps/radioedit/envs 
    /data/apps/radioedit/envs/core 
    /var/run/radioedit 
    /var/log/radioedit 
    /data/apps/radioedit/shared 
  };
  default[:radioedit][:packages] = %w{ 
    libevent 
    memcached 
    python27 
    python27-libs 
    python27-devel 
    python27-test 
    python27-tools 
    nginx 
    zlib-devel 
    openjpeg-devel 
    zlib 
    gcc 
    python-devel 
    git 
    libevent-devel 
    zeromq-devel 
    zeromq 
    python-setuptools 
    python-ldap 
    postgresql-devel 
    openldap-devel 
    varnish 
    readline-devel 
    patch 
    libjpeg-devel
    nginx
    rsyslog
    libxml2-devel
    libxslt-devel
    libvmod
    libvmod-statsd
  };
  default[:radioedit][:pips] = %w{ 
    lxml
    supervisor 
    pymongo 
    python-memcached 
    greenlet 
    statsd 
    pyzmq 
    flask 
    flask-cache 
    flask-pymongo 
    pillow 
    blinker 
    celery 
    colorama 
    docutils 
    gevent-websocket 
    jsonschema 
    mock 
    pql 
    pyparsing 
    python-dateutil 
    python-ldap 
    requests 
    simplejson 
    raven 
    pytest 
  };
# End of stage settings

# ################################################################
# Development Environment settings.
# ################################################################
else

  override[:memcached][:memory]  = 64;
  
  default[:radioedit][:path] = "/data/apps/radioedit";
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-core.pid"
  default[:radioedit][:log_dir] = "/var/log/radioedit"
  default[:radioedit][:out_log] = "#{default[:radioedit][:log_dir]}/application.log"
  default[:radioedit][:err_log] = "#{default[:radioedit][:log_dir]}/application.err"
  default[:radioedit][:venv_path] = "#{default[:radioedit][:path]}/envs/core";
  default[:radioedit][:module] = "wsgi"
  default[:radioedit][:app_name] = "radioedit-core"
  default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
  default[:radioedit][:varnish_backend_port] = "8080"
  default[:radioedit][:varnish_backend_ip] = "127.0.0.1"
  default[:radioedit][:branch] = "release"
  default[:radioedit][:intbranch] = "testing"
  default[:radioedit][:env] = "ihr_testing"
  default[:radioedit][:num_workers] = 5
  default[:radioedit][:log_level] = "DEBUG"
  default[:radioedit][:port] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:listen] = "/var/tmp/radioedit-cms.sock"
  default[:radioedit][:host] = "unix"
  default[:radioedit][:utildir] = "#{default[:radioedit][:path]}/util"
  default[:radioedit][:asset_dir] = "/data/binstore"
  default[:radioedit][:cdn_url] = "http://10.5.1.29/"
  default[:radioedit][:elastic_clustername] = "radioedit-dev";
  default[:radioedit][:mongo_cstring] = "mongodb://use1b-radioedit-test102.ihr:37017,use1b-radioedit-test103.ihr:37017,use1b-radioedit-test104.ihr:37017/radioedit-f?replicaSet=RadioEdit1"
  default[:radioedit][:req_dirs] = %w{ 
    /data 
    /data/binstore
    /data/apps 
    /data/apps/radioedit 
    /data/apps/radioedit/util 
    /data/apps/radioedit/static
    /data/apps/radioedit/releases 
    /data/apps/radioedit/envs 
    /data/apps/radioedit/envs/core 
    /var/run/radioedit 
    /var/log/radioedit 
    /data/apps/radioedit/shared 
  };

  default[:radioedit][:packages] = %w{
    libevent 
    memcached 
    python27 
    python27-libs 
    python27-devel 
    python27-test 
    python27-tools 
    nginx 
    zlib-devel 
    openjpeg-devel 
    zlib 
    gcc 
    python-devel 
    git 
    libevent-devel 
    zeromq-devel 
    zeromq 
    python-setuptools 
    python-ldap 
    postgresql-devel 
    openldap-devel 
    varnish 
    readline-devel 
    patch 
    libjpeg-devel
    nginx
    rsyslog
    libxml2-devel
    libxslt-devel
    libvmod
    libvmod-statsd
  };

  default[:radioedit][:pips] = %w{ 
    lxml
    supervisor 
    pymongo 
    python-memcached 
    greenlet 
    statsd 
    pyzmq 
    flask 
    flask-cache 
    flask-pymongo 
    pillow 
    blinker 
    celery 
    colorama 
    docutils 
    gevent-websocket 
    jsonschema 
    mock 
    pql 
    pyparsing 
    python-dateutil 
    python-ldap 
    requests 
    simplejson 
    raven 
    pytest 
  };
  
# END Development Environment settings.
end


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
