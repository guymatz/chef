#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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

package "memcached" do
  action :upgrade
end

package "libmemcache-dev" do
  case node[:platform]
  when "redhat","centos","fedora"
    package_name "libmemcached-devel"
  else
    package_name "libmemcache-dev"
  end
  action :upgrade
end


node[:fqdn] =~ /(\w+-\w+)(\d{3})/
cluster_name = $1 + '-cache'

case node[:platform_family]
when "rhel"
  begin
    if Chef::Config[:solo]
      Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
    else
      memcached_instances = search(:memcached, "id:#{cluster_name}")[0]
    end
    Chef::Log.info("Found memcached cluster: #{cluster_name}.")
  rescue Net::HTTPServerException
    Chef::Log.info("Could not search for memcached for cluster #{cluster_name}.")
    return # nothing else to do
  end

  service "memcached" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action :nothing
  end

  template "/etc/init.d/memcached" do
    source "memcached.init.erb"
    owner "root"
    group "root"
    mode "0751"
  end

  directory "/var/run/memcached" do
    owner "nobody"
    group "nobody"
  end

  # zero this file for us
  file "/etc/sysconfig/memcached" do
    content ""
    owner "root"
    group "root"
    mode "0644"
  end

  # for each instance of memcached, create /etc/sysconfig/memcached_<PORT>
  unless memcached_instances.nil? || memcached_instances.empty?
    memcached_instances['instances'].each do |mc|
      Chef::Log.info("Setting up Memcached instance: " + mc.inspect)
      Chef::Log.info("Creating /etc/sysconfig/memcached_#{mc[:port]}")
      if mc[:listen].nil?
        listen="0.0.0.0"
      else
        listen = mc[:listen]
      end
      template "/etc/sysconfig/memcached_#{mc[:port]}" do
        source "memcached.sysconfig.erb"
        owner "root"
        group "root"
        mode "0644"
        options = Array.new
        options.push('-vv >> /var/log/memcached 2>&1')
        variables(
                  :listen => listen,
                  :user => node[:memcached][:user],
                  :port => node[:memcached][:port],
                  :maxconn => mc[:maxconn],
                  :memory => mc[:memory],
                  :options => options
                  )
        notifies :restart, "service[memcached]", :immediately
      end
    end
  end

  service "memcached" do
    supports :status => true, :start => true, :stop => true, :restart => true
    action [:enable, :start]
  end

end
