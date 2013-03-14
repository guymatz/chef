default[:pkgs] = [ 'nginx','collectd','collectd-nginx','zlib-devel','libjpeg','zlib','gcc', 'python-devel','git','libevent-devel','libevent','zeromq-devel','zeromq', 'python-setuptools', 'python-ldap', 'python-zmq', 'varnish', 'python-imaging', 'python-psycopg2' ]
default[:pips] = [ 'supervisor','pymongo','python-memcached', 'gunicorn','greenlet', 'statsd', 'flask', 'jinja2', 'sqlalchemy', 'werkzeug', 'pyparsing', 'wsgiref' ]
default[:supervisor][:app] = { "imgproxy" => { "environment" => "IMAGE_SERVER_CONF=conf/prod.py",
                                               "command" => "/usr/bin/gunicorn -w 10 -b unix:/tmp/imgproxy.sock -p /var/run/imgproxy.pid server:app",
                                               "directory" => "/opt/image"
                                             }
                             }
default[:supervisor][:process_dir] = "/etc/supervisor.d"
default[:varnish][:app_port] = 8000
default[:nginx][:web_dir] = "/etc/nginx.d"
#node[:supervisor][:directives]
