#
# Cookbook Name:: haproxy
# Recipe:: app_lb
#
# Copyright 2011, Opscode, Inc.
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

package "haproxy" do
  action :install
end

cookbook_file "/etc/haproxy/haproxy.cfg" do
  owner "root"
  group "root"
  mode 0644
end

#cookbook_file "/etc/rsyslog.d/haproxy.conf" do
#  source "haproxy.conf"
#  mode "0644"
#  owner "root"
#  group "root"
#  action :create_if_missing
#  only_if "test -d /etc/rsyslog.d"
#  notifies :restart, "service[rsyslog]"
#end

service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end
