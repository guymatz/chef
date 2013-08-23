
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

# epona settings
default[:radioedit][:epona][:path] = "/data/apps/radioedit";
default[:radioedit][:epona][:repo] = "git@github.ihrint.com:radioedit/core.git"
default[:radioedit][:epona][:branch] = "deploy"
default[:radioedit][:epona][:port] = 8000
default[:radioedit][:epona][:host] = "unix"
default[:radioedit][:epona][:packages] = %w{ python27 python27-libs python27-devel python27-test python27-tools nginx zlib-devel libjpeg zlib gcc python-devel git libevent-devel libevent zeromq-devel zeromq python-setuptools python-ldap postgresql-devel openldap-devel varnish readline-devel patch libjpeg-devel }
default[:radioedit][:epona][:pips] = %w{ supervisor pymongo python-memcached gunicorn greenlet statsd pyzmq }