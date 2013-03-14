#
# Cookbook Name:: imgproxy
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::epel"

rpm_package "varhnish_repo" do
  action :install
  options "--no-signature"
  source "http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm"
end

pkgs = [ 'nginx','collectd','collectd-nginx','zlib-devel','libjpeg','zlib','gcc', 'python-devel','git','libevent-devel','libevent','zeromq-devel','zeromq', 'python-setuptools', 'python-ldap', 'python-zmq', 'varnish', 'python-imaging', 'python-psycopg2' ]

pkgs.each do |pkg|
  package pkg
end

pips = [ 'supervisor','pymongo','python-memcached', 'gunicorn','greenlet', 'statsd', 'flask', 'jinja2', 'sqlalchemy', 'werkzeug', 'pyparsing', 'wsgiref' ]

pips.each do |pip|
  python_pip pip
end

static_files = { "/etc/sudoers.d/keep_agent" => "keep_agent",
                 "/etc/ssh/ssh_config" => "ssh_conf",
                 "/etc/nginx/proxy_params" => "nginx_proxy_params",
                 "/etc/init.d/supervisor" => "supervisor_init",
                 "/etc/sysconfig/varnish" => "varnish_sysconfig",
                 "/opt/varnish_carbon.py" => "varnish_carbon.py"
               }

static_files.each do |dest,src|
  cookbook_file dest do
    source src
    if dest.include?("init") || dest.include?("py")
      mode "755"
    end
  end
end

template_files = { "/etc/supervisord.conf" => "supervisor.erb",
                   "/etc/nginx/nginx.conf" => "nginx.erb",
                   "/etc/varnish/default.vcl" => "varnish.vcl.erb"
                 }

template_files.each do |dest,src|
  template dest do
    source src
  end
end

template "/opt/supervisor.d/imgproxy" do
  source "supervisor.conf.erb"
  variables(:name => "imgproxy")
end

bash "install_supervisor_service" do
  user "root"
  code "chkconfig --add supervisor"
end



files:
 FileXfer('deploy/assets/keep_agent.txt', '/etc/sudoers.d/keep_agent', sudo=True, mode=0440, owner=0, group=0),
    FileXfer('deploy/assets/ssh_conf.txt', '/etc/ssh/ssh_config', sudo=True, mode=644),
    FileXfer('deploy/assets/nginx_proxy_params.txt', '/etc/nginx/proxy_params', sudo=True),
    FileXfer('deploy/assets/supervisor_init.txt', '/etc/init.d/supervisor', sudo=True, mode=755),
    FileXfer('deploy/assets/supervisor.txt', '/etc/supervisord.conf', template=True, sudo=True),
    FileXfer('deploy/assets/nginx.txt', '/etc/nginx/nginx.conf', template=True, sudo=True),

services:

Command('chkconfig --add supervisor', sudo=True),
    Command('chkconfig --level 345 supervisor on', sudo=True),
    Command('chkconfig --level 345 nginx on', sudo=True),
    Command('chkconfig --level 345 collectd on', sudo=True),


