#
# Cookbook Name::       cassandra
# Description::         Server
# Recipe::              server
# Author::              Benjamin Black (<b@b3k.us>)
#
# Copyright 2010, Flip Kromer
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

include_recipe "runit"

directory('/etc/sv/cassandra/env'){ owner 'root' ; action :create ; recursive true }
#runit_service "cassandra" do
#  options       node[:cassandra]
#  run_state     node[:cassandra][:run_state]
#end

template "/etc/init.d/cassandra" do
	source "cassandra.erb"
	owner "root"
	group "root"
	mode 0755
	variables({
		:cassandra => node[:cassandra]
	})
end

service "cassandra" do
   supports :status => true, :restart => true, :reload => true
   action [ :enable, :start ]
end

link "/etc/cassandra" do
   to "/usr/local/share/cassandra-#{node[:cassandra][:version]}/conf"
end

include_recipe("cassandra::authentication")

template "#{node[:cassandra][:conf_dir]}/log4j-server.properties" do
  source        "log4j-server.properties.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :cassandra => node[:cassandra]
  notifies      :restart, "service[cassandra]"
end

##Removing seed discovery logic, we will hand code the seed nodes to prevent any node from having itself in it's seed list, since node rebuilds do not work in that case
# have some fraction of the nodes announce as a seed
#if ( node[:cassandra][:seed_node] || (node[:facet_index].to_i % 3 == 0) )
#  announce(:cassandra, :seed)
#end

# Discover the other seeds, assuming they've a) announced and b) converged.
# Might be better to instead do
#    seed_ips = discover_all(:cassandra, :seed).sort_by{|s| s.node.name }.map{|s| s.node.ipaddress }
#seed_ips = []
#discover_all(:cassandra, :seed).each do |s|
#  seed_ips << s.node.ipaddress
#end
# stabilize their order.
#seed_ips.sort!

# This is racy like a dirty joke at the indy 500, but any proper fix would
# require orchestration. Since a node with facet_index 0 is always a seed,
# spinning that one up first leads to reasonable results in practice.
#
template "#{node[:cassandra][:conf_dir]}/cassandra.yaml" do
  source        "cassandra.yaml.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables({
                :cassandra => node[:cassandra],
    })
  notifies      :restart, "service[cassandra]"
end

template "#{node[:cassandra][:conf_dir]}/cassandra-env.sh" do
  source        "cassandra-env.sh.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables({
                :hostname => node[:hostname],
    })
  notifies      :restart, "service[cassandra]"
end
