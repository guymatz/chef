# Cookbook Name:: varnish
# Recipe:: default
# Author:: Joe Williams <joe@joetify.com>
# Contributor:: Patrick Connolly <patrick@myplanetdigital.com>
#
# Copyright 2008-2009, Joe Williams
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "varnish"

template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}" do
  source node['varnish']['vcl_source']
  if node['varnish']['vcl_cookbook']
    cookbook node['varnish']['vcl_cookbook']
  end
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[varnish]"
end

template node['varnish']['default'] do
  source "custom-default.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[varnish]"
end

file "/etc/logrotate.d/varnish" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

logrotate_app "varnish" do
  cookbook logrotate
  path "/var/log/varnish/varnish.log"
  options ["missingok", "delaycompress", "compress", "notifempty", "sharedscripts"]
  frequency "daily"
  enable true
  rotate 5
  size "2G"
  postrotate [
    "/bin/kill -HUP `cat /var/run/varnishlog.pid 2>/dev/null` 2> /dev/null || true",
    "/bin/kill -HUP `cat /var/run/varnishncsa.pid 2>/dev/null` 2> /dev/null || true"
  ]
end

#  size (1024**2)*2 # 2MB
#  postrotate "find #{node[:apache][:log_dir]} -name '*.gz*' -exec rm -rf {} \\;"
