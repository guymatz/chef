#Place where application will live
default[:pkgs] = [ 'nginx','collectd','collectd-nginx','zlib-devel','libjpeg','zlib','gcc', 'python-devel','git','libevent-devel','libevent','zeromq-devel','zeromq', 'python-setuptools', 'python-ldap', 'python-zmq', 'varnish', 'python-imaging', 'python-psycopg2' ]
default[:pips] = [ 'supervisor','pymongo','python-memcached', 'gunicorn','greenlet', 'statsd', 'flask', 'jinja2', 'sqlalchemy', 'werkzeug', 'pyparsing', 'wsgiref' ]
default[:supervisor][:imgproxy][:dir] = "/opt/image"
default[:supervisor][:app] = { "imgproxy" => { "environment" => "IMAGE_SERVER_CONF=conf/prod.py",
                                               "command" => "/usr/bin/gunicorn -w 10 -b unix:/tmp/imgproxy.sock -p /var/run/imgproxy.pid server:app",
                                               "directory" => default[:supervisor][:imgproxy][:dir]
                                             }
                             }
default[:supervisor][:process_dir] = "/etc/supervisor.d"
default[:supervisor][:run_dirs] = [ "/var/log/supervisor" ]
default[:varnish_repo] = "http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm"
default[:varnish][:app_port] = 8000
default[:nginx][:web_dir] = "/etc/nginx.d"
default[:imgproxy][:static_files] = { "/etc/sudoers.d/keep_agent" => "keep_agent",
                                      "/etc/ssh/ssh_config" => "ssh_conf",
                                      "/etc/nginx/proxy_params" => "nginx_proxy_params",
                                      "/etc/init.d/supervisor" => "supervisor_init",
                                      "/etc/sysconfig/varnish" => "varnish_sysconfig",
                                      "/opt/varnish_carbon.py" => "varnish_carbon.py"
                                    }
default[:imgproxy][:template_files] = { "/etc/supervisord.conf" => "supervisord.conf.erb",
                                        "/etc/nginx/nginx.conf" => "nginx.erb",
                                        "/etc/varnish/default.vcl" => "varnish.vcl.erb"
                                      }
#node[:supervisor][:directives]
