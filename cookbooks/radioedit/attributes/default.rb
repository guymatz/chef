
# User Settings

default[:radioedit][:user] = "nobody"
case node[:platform_family]
when "rhel"
  default[:radioedit][:group] = "nobody"
when "debian"
  default[:radioedit[:group]] = "nogroup"
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

default[:radioedit][:cms][:repo] = "git@github.com:iheartradio/featuredcontent.git"
default[:radioedit][:cms][:branch] = "deploy"

# Requirements
default[:radioedit][:image][:packages] = %w{ python-imaging python-psycopg2 postgresql-libs }

default[:radioedit][:cms][:packages] = %w{ python-psycopg2 postgresql-libs }

default[:radioedit][:core][:packages] = %w{ nginx zlib-devel libjpeg zlib gcc python-devel git libevent-devel libevent zeromq-devel zeromq python-setuptools python-ldap }
default[:radioedit][:core][:pips] = %w{ supervisor pymongo python-memcached gunicorn greenlet statsd pyzmq }

default[:radioedit][:diablocore][:packages] = %w{ nginx zlib-devel libjpeg zlib gcc python-devel git libevent-devel libevent zeromq-devel zeromq }

# Gunicorn Settings
default[:radioedit][:image][:port] = 8000
default[:radioedit][:image][:listen] = "/var/tmp/radioedit-image.sock"

default[:radioedit][:cms][:port] = 80
default[:radioedit][:cms][:listen] = "/var/tmp/radioedit-cms.sock"
default[:radioedit][:cms][:host] = "/var/tmp/radioedit-cms.sock"
