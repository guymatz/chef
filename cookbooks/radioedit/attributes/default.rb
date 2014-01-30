
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

# ################################################################
# Development Environment settings.
# ################################################################
default[:radioedit][:dev][:path] = "/data/apps/radioedit";
default[:radioedit][:dev][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
default[:radioedit][:dev][:log_dir] = "/var/log/radioedit"
default[:radioedit][:dev][:out_log] = "#{default[:radioedit][:dev][:log_dir]}/application.log"
default[:radioedit][:dev][:err_log] = "#{default[:radioedit][:dev][:log_dir]}/application.err"
default[:radioedit][:dev][:venv_path] = "#{default[:radioedit][:dev][:path]}/envs/core";
default[:radioedit][:dev][:module] = "wsgi"
default[:radioedit][:dev][:app_name] = "radioedit-core"
default[:radioedit][:dev][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:dev][:branch] = "release"
default[:radioedit][:dev][:intbranch] = "testing"
default[:radioedit][:dev][:env] = "ihr_testing"
default[:radioedit][:dev][:num_workers] = 5
default[:radioedit][:dev][:log_level] = "DEBUG"
default[:radioedit][:dev][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:dev][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:dev][:host] = "unix"
default[:radioedit][:dev][:utildir] = "#{default[:radioedit][:dev][:path]}/util"
default[:radioedit][:dev][:asset_dir] = "/data/binstore"
default[:radioedit][:dev][:cdn_url] = "http://10.5.1.29/"
default[:radioedit][:dev][:elastic_clustername] = "radioedit-dev";
default[:radioedit][:dev][:mongo_cstring] = "mongodb://use1b-radioedit-test102.ihr:37017,use1b-radioedit-test103.ihr:37017,use1b-radioedit-test104.ihr:37017/radioedit-f?replicaSet=RadioEdit1"
default[:radioedit][:dev][:req_dirs] = %w{ 
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
default[:radioedit][:dev][:packages] = %w{
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
  libxslt-devel
}
default[:radioedit][:dev][:pips] = %w{ 
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
  lxml
}
# ################################################################
# END Development Environment settings.
# ################################################################


# ################################################################
# Staging Environment settings.
# ################################################################
default[:radioedit][:staging][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:staging][:branch] = "staging"
default[:radioedit][:staging][:env] = "ihr_testing"
default[:radioedit][:staging][:path] = "/data/apps/radioedit";
default[:radioedit][:staging][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
default[:radioedit][:staging][:log_dir] = "/var/log/radioedit"
default[:radioedit][:staging][:out_log] = "#{default[:radioedit][:staging][:log_dir]}/application.log"
default[:radioedit][:staging][:err_log] = "#{default[:radioedit][:staging][:log_dir]}/application.err"
default[:radioedit][:staging][:venv_path] = "#{default[:radioedit][:staging][:path]}/envs/core";
default[:radioedit][:staging][:module] = "wsgi:application"
default[:radioedit][:staging][:app_name] = "radioedit-core"
default[:radioedit][:staging][:num_workers] = 5
default[:radioedit][:staging][:log_level] = "DEBUG"
default[:radioedit][:staging][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:staging][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:staging][:host] = "unix"
default[:radioedit][:staging][:utildir] = "#{default[:radioedit][:staging][:path]}/util"
default[:radioedit][:staging][:staticdir] = "#{default[:radioedit][:staging][:path]}/static"
default[:radioedit][:staging][:asset_dir] = "/data/binstore"
default[:radioedit][:staging][:cdn_url] = "http://10.5.1.28/"
default[:radioedit][:staging][:elastic_clustername] = "radioedit-staging";
default[:radioedit][:staging][:mongo_cstring] = "mongodb://use1b-radioedit-test102.ihr:37017,use1b-radioedit-test103.ihr:37017,use1b-radioedit-test104.ihr:37017/radioedit-epona?replicaSet=RadioEdit1"
default[:radioedit][:staging][:req_dirs] = %w{ 
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
default[:radioedit][:staging][:packages] = %w{ 
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
  libxslt-devel
}
default[:radioedit][:staging][:pips] = %w{ 
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
  lxml
}
# ################################################################
# End of staging env
# ################################################################

# ################################################################
# PRODUCTION SETTINGS!!!!!
# ################################################################
default[:radioedit][:production][:repo] = "git@github.ihrint.com:radioedit/core.git";
default[:radioedit][:production][:branch] = "ganon.2";
default[:radioedit][:production][:env] = "ihr_testing";
default[:radioedit][:production][:app_user] = "ihr-deployer";
default[:radioedit][:production][:path] = "/data/apps/radioedit";
default[:radioedit][:production][:pid_file] = "/var/run/radioedit/radioedit-epona.pid";
default[:radioedit][:production][:log_dir] = "/var/log/radioedit";
default[:radioedit][:production][:out_log] = "#{default[:radioedit][:production][:log_dir]}/application.log";
default[:radioedit][:production][:err_log] = "#{default[:radioedit][:production][:log_dir]}/application.err";
default[:radioedit][:production][:venv_path] = "#{default[:radioedit][:production][:path]}/envs/core";
default[:radioedit][:production][:module] = "wsgi";
default[:radioedit][:production][:app_name] = "radioedit-core";
default[:radioedit][:production][:num_workers] = 5;
default[:radioedit][:production][:log_level] = "WARNING";
default[:radioedit][:production][:port] = "/var/tmp/radioedit-cms.sock";
default[:radioedit][:production][:listen] = "/var/tmp/radioedit-cms.sock";
default[:radioedit][:production][:host] = "unix";
default[:radioedit][:production][:utildir] = "#{default[:radioedit][:production][:path]}/util";
default[:radioedit][:production][:staticdir] = "#{default[:radioedit][:production][:path]}/static";
default[:radioedit][:production][:asset_dir] = "/data/binstore/assets";
default[:radioedit][:production][:cdn_url] = "http://imgproxy.iheart.com/";
default[:radioedit][:production][:mongo_cstring] = "mongodb://iad-mongo-shared101.ihr:37017,iad-mongo-shared102.ihr:37017,iad-mongo-shared103.ihr:37017/radioedit?replicaSet=Mongo-shared1";
default[:radioedit][:production][:nfs_server] = "10.5.40.121";
default[:radioedit][:production][:nfs_remdir] = "/data/imgscaler/radioedit";
default[:radioedit][:production][:nfs_locdir] = "/data/binstore";
default[:radioedit][:production][:elastic_clustername] = "radioedit";
default[:radioedit][:production][:deploy_tag] = "radioedit-deployed";
default[:radioedit][:production][:varnish_backend_port] = "8080";
default[:radioedit][:production][:varnish_backend_ip] = "127.0.0.1";
default[:radioedit][:production][:req_dirs] = %w{ 
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
default[:radioedit][:production][:packages] = %w{ 
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
  libxslt-devel
};
default[:radioedit][:production][:pips] = %w{ 
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
  lxml 
};
# ################################################################
# END PRODUCTION SETTINGS
# ################################################################





