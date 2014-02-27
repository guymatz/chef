# User Settings

default[:radioedit][:user] = "ihr-deployer"
case node[:platform_family]
when "rhel"
  default[:radioedit][:group] = "ihr-deployer"
when "debian"
  default[:radioedit[:group]] = "ihr-deployer"
end

# ZeroMQ repo
default[:zeromq][:repo_url] = ""

# Installation Settings
default[:radioedit][:install_path] = "/data/apps/radioedit"
default[:radioedit][:image][:path] = "/data/apps/radioedit/images"
default[:radioedit][:cms][:path] = "/data/apps/radioedit/radioedit-core"

# Application Repositories
default[:radioedit][:image][:repo] = "git@github.com:iheartradio/radioedit-img.git"
default[:radioedit][:image][:branch] = "deploy"
default[:radioedit][:cms][:repo] = "git@github.com:iheartradio/featcontent.git"
default[:radioedit][:cms][:branch] = node.run_list.include?('role[radioedit_server_a]') ? 'deploy_a_release' : 'deploy'
default[:radioedit][:cms][:static] = node.run_list.include?('role[radioedit_server_a]') ? 'staticv1' : 'static'

# Requirements
default[:radioedit][:image][:packages] = %w{ python-imaging python-psycopg2 postgresql-libs }
default[:radioedit][:cms][:packages] = %w{ python-psycopg2 postgresql-libs libjpeg-devel }
default[:radioedit][:core][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools nginx zlib-devel libjpeg zlib gcc python-devel git libevent-devel libevent zeromq-devel zeromq python-setuptools python-ldap postgresql-devel openldap-devel varnish readline-devel patch libjpeg-devel }
default[:radioedit][:core][:pips] = %w{ supervisor pymongo python-memcached gunicorn greenlet statsd pyzmq }
default[:radioedit][:diablocore][:packages] = %w{ nginx zlib-devel libjpeg zlib gcc python-devel git libevent-devel libevent zeromq-devel zeromq }

# Gunicorn Settings
default[:radioedit][:image][:port] = 8000
default[:radioedit][:image][:listen] = "/var/tmp/radioedit-image.sock"

default[:radioedit][:cms][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:cms][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:cms][:host] = "unix"

default[:radioedit][:nginx][:port] = 8000

# Environment specific settings start here
case chef_environment
when /^prod/
  # ################################################################
  # PRODUCTION SETTINGS!!!!!
  # ################################################################
  default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
  default[:radioedit][:branch] = "ganon.5"
  default[:radioedit][:env] = "ihr_testing"
  default[:radioedit][:app_user] = "ihr-deployer"
  default[:radioedit][:path] = "/data/apps/radioedit"
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
  default[:radioedit][:log_dir] = "/var/log/radioedit"
  default[:radioedit][:out_log] = "#{default[:radioedit][:log_dir]}/application.log"
  default[:radioedit][:err_log] = "#{default[:radioedit][:log_dir]}/application.err"
  default[:radioedit][:venv_path] = "#{default[:radioedit][:path]}/envs/core"
  default[:radioedit][:module] = "wsgi"
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
  }
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
  }
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
  }
  # ################################################################
  # END PRODUCTION SETTINGS
  # ################################################################
when /^stage/
  # ################################################################
  # Staging Environment settings.
  # ################################################################
  default[:radioedit][:repo] = "git@github.ihrint.com:radioedit/core.git"
  default[:radioedit][:branch] = "staging"
  default[:radioedit][:env] = "ihr_testing"
  default[:radioedit][:path] = "/data/apps/radioedit";
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
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
  default[:radioedit][:mongo_cstring] = "mongodb://use1b-radioedit-test102.ihr:37017,use1b-radioedit-test103.ihr:37017,use1b-radioedit-test104.ihr:37017/radioedit-epona?replicaSet=RadioEdit1"
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
  }
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
  }
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
  }
  # ################################################################
  # End of staging env
  # ################################################################
else
  # ################################################################
  # Development Environment settings.
  # ################################################################
  default[:radioedit][:path] = "/data/apps/radioedit";
  default[:radioedit][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
  default[:radioedit][:log_dir] = "/var/log/radioedit"
  default[:radioedit][:out_log] = "#{default[:radioedit][:log_dir]}/application.log"
  default[:radioedit][:err_log] = "#{default[:radioedit][:log_dir]}/application.err"
  default[:radioedit][:staticdir] = "#{default[:radioedit][:path]}/static"
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
  }
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
  }
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
  }
  # ################################################################
  # END Development Environment settings.
  # ################################################################
end
