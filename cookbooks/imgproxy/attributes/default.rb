node[:supervisor][:app] = "imgproxy" => { "environment" => "IMAGE_SERVER_CONF=conf/prod.py",
                                          "command" => "/usr/bin/gunicorn -w 10 -b unix:/tmp/imgproxy.sock -p /var/run/imgproxy.pid server:app",
                                          "directory" => "/opt/image"
                                        }
node[:supervisor][:process_dir] = "/etc/supervisor.d"
node[:nginx][:web_dir] = "/etc/nginx.d"
#node[:supervisor][:directives]
