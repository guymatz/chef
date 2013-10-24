
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
# PRODUCTION SETTINGS!!!!!
# ################################################################
default[:radioedit][:bob][:req_dirs] = %w{ 
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
default[:radioedit][:bob][:packages] = %w{ 
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
}
default[:radioedit][:bob][:pips] = %w{ 
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
  pylibmc 
  pyparsing 
  python-dateutil 
  python-ldap 
  requests 
  simplejson 
  raven 
  pytest 
}
default[:radioedit][:bob][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:bob][:branch] = "staging"
default[:radioedit][:bob][:env] = "ihr_testing"
default[:radioedit][:bob][:path] = "/data/apps/radioedit";
default[:radioedit][:bob][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
default[:radioedit][:bob][:log_dir] = "/var/log/radioedit"
default[:radioedit][:bob][:out_log] = "#{default[:radioedit][:bob][:log_dir]}/application.log"
default[:radioedit][:bob][:err_log] = "#{default[:radioedit][:bob][:log_dir]}/applicaiton.err"
default[:radioedit][:bob][:venv_path] = "#{default[:radioedit][:bob][:path]}/envs/core";
default[:radioedit][:bob][:module] = "wsgi:application"
default[:radioedit][:bob][:num_workers] = 5
default[:radioedit][:bob][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:bob][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:bob][:host] = "unix"
default[:radioedit][:bob][:utildir] = "#{default[:radioedit][:bob][:path]}/util"
default[:radioedit][:bob][:staticdir] = "#{default[:radioedit][:bob][:path]}/static"
# ################################################################
# End of 'bob' env
# ################################################################

# epona settings
default[:radioedit][:epona][:req_dirs] = %w{ 
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
default[:radioedit][:epona][:packages] = %w{ 
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
}
default[:radioedit][:epona][:pips] = %w{ 
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
  pylibmc 
  pyparsing 
  python-dateutil 
  python-ldap 
  requests 
  simplejson 
  raven 
  pytest 
}
default[:radioedit][:epona][:path] = "/data/apps/radioedit";
default[:radioedit][:epona][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
default[:radioedit][:epona][:log_dir] = "/var/log/radioedit"
default[:radioedit][:epona][:out_log] = "#{default[:radioedit][:epona][:log_dir]}/epona.log"
default[:radioedit][:epona][:err_log] = "#{default[:radioedit][:epona][:log_dir]}/epona.err"
default[:radioedit][:epona][:venv_path] = "#{default[:radioedit][:epona][:path]}/envs/core";
default[:radioedit][:epona][:module] = "wsgi:application"
default[:radioedit][:epona][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:epona][:branch] = "release"
default[:radioedit][:epona][:intbranch] = "testing"
default[:radioedit][:epona][:packages] = %w{ libevent memcached python27 python27-libs python27-devel python27-test python27-tools nginx zlib-devel openjpeg-devel zlib gcc python-devel git libevent-devel zeromq-devel zeromq python-setuptools python-ldap postgresql-devel openldap-devel varnish readline-devel patch libjpeg-devel }
default[:radioedit][:epona][:pips] = %w{ supervisor pymongo python-memcached greenlet statsd pyzmq flask flask-cache flask-pymongo pillow blinker celery colorama docutils gevent-websocket jsonschema mock pql pylibmc pyparsing python-dateutil python-ldap requests simplejson raven pytest }
default[:radioedit][:epona][:env] = "ihr_testing"
default[:radioedit][:epona][:num_workers] = 5
default[:radioedit][:epona][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:epona][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:epona][:host] = "unix"
default[:radioedit][:epona][:utildir] = "#{default[:radioedit][:epona][:path]}/util"
# End Epona QA environment attributes


# ################################################################
# PRODUCTION SETTINGS!!!!!
# ################################################################
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
}
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
}
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
  pylibmc 
  pyparsing 
  python-dateutil 
  python-ldap 
  requests 
  simplejson 
  raven 
  pytest 
}
default[:radioedit][:production][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:production][:branch] = "release"
default[:radioedit][:production][:env] = "ihr_testing"
default[:radioedit][:production][:path] = "/data/apps/radioedit";
default[:radioedit][:production][:pid_file] = "/var/run/radioedit/radioedit-epona.pid"
default[:radioedit][:production][:log_dir] = "/var/log/radioedit"
default[:radioedit][:production][:out_log] = "#{default[:radioedit][:production][:log_dir]}/application.log"
default[:radioedit][:production][:err_log] = "#{default[:radioedit][:production][:log_dir]}/applicaiton.err"
default[:radioedit][:production][:venv_path] = "#{default[:radioedit][:production][:path]}/envs/core";
default[:radioedit][:production][:module] = "wsgi:application"
default[:radioedit][:production][:num_workers] = 5
default[:radioedit][:production][:port] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:production][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:production][:host] = "unix"
default[:radioedit][:production][:utildir] = "#{default[:radioedit][:production][:path]}/util"
default[:radioedit][:production][:staticdir] = "#{default[:radioedit][:production][:path]}/static"
# ################################################################
# END PRODUCTION SETTINGS
# ################################################################




