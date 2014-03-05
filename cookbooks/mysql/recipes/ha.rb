require 'socket'

include_recipe "heartbeat"

Chef::Log.info "node=#{node[:fqdn]}"
if node[:fqdn] =~ /(use1b[a-z0-9-]+)([a|b])(\.ihr)?/i
  cluster_name = $1
  cluster_member = $2
  cluster_prefix = cluster_name
  case cluster_member
  when "a"
	cluster_node = 1
  when "b"
	cluster_node = 2
  end
elsif node[:fqdn] =~ /(iad[a-z-]+)(10)([0-9])(\.ihr)?/i
  cluster_prefix=$1
  cluster_node=$3
  if node.chef_environment =~ /^production/
	cluster_name="#{cluster_prefix}"
  elsif node.chef_environment =~ /^stage/
	cluster_name="#{cluster_prefix}-v760.ihr"
  end
end

Chef::Log.info "cluster_name=#{cluster_name}, cluster_member=#{cluster_node}"
cluster_ip = IPSocket::getaddress(cluster_name)
Chef::Log.info "cluster_ip=#{cluster_ip}"

if node.chef_environment == "ec2-prod"
  cluster_netmask = "255.255.255.0"
else
  cluster_netmask = "255.255.254.0"
end
case node[:platform_family]
when "debian"
  cluster_intf = "eth0"
when "rhel"
  cluster_intf = "bond0.760"
end
shortname = node[:hostname]


cluster_slaves = search(:node, "roles:mysql-ha AND chef_environment:#{node.chef_environment} AND hostname:#{cluster_prefix}* AND NOT hostname:#{shortname}")


Chef::Log.info("Checking HB Authkeys")
if node['heartbeat']['config']['authkeys'].nil?
  genkey = true
  Chef::Log.info("No Authkey Found")
  Chef::Log.info("Missing authkeys, searching for other nodes that might have one")
  # This node doesn't have a key, but maybe the other one(s) do
  cluster_slaves.each do |js|
    Chef::Log.info("checking for key on #{node['fqdn']}")
    begin
      unless js['heartbeat']['config']['authkeys'].nil?
        Chef::Log.info("Found a key to use on #{js['fqdn']}")
        node.set['heartbeat']['config']['authkeys'] = js['heartbeat']['config']['authkeys']
        node.save
        genkey = false
        break
      end
      rescue
    end
    if genkey
      Chef::Log.info("No keys found on other node, generating secure key")
      # could not find a key, let's make one
      node.set_unless['heartbeat']['config']['authkeys'] = secure_password
      node.save
    end
  end
end

ha_resources = Array.new
ha_resources.push("IPaddr::#{cluster_ip}/#{cluster_netmask}/#{cluster_intf}")
begin
    node[:heartbeat][:ha_resources].each do |k,v|
        ha_resources.push(v)
      end
    rescue NoMethodError
  end

puts "cluster_slaves.first:" + cluster_slaves.first.inspect

heartbeat "mysql-heartbeat" do
  auto_failback false
  autojoin "none"
  #deadtime 30
  initdead 30
  logfacility "local0"
  authkeys node[:heartbeat][:config][:authkeys]
  warntime 15
  search "chef_environment:#{node.chef_environment} AND roles:mysql-ha AND hostname:#{cluster_prefix}*"
  interface "eth0"
  interface_partner_ip IPSocket::getaddress(cluster_slaves.first[:fqdn])
  mode "ucast"
  resource_groups ha_resources
end

puts "Settings up replication with: " + cluster_slaves.inspect

ruby_block "create-replication-users" do
  block do
    cluster_slaves.each do |slave|
      %x{mysql -u root -p#{node[:mysql][:server_root_password]} -e "GRANT REPLICATION SLAVE ON *.* to 'repl'@'#{slave[:ipaddress]}' IDENTIFIED BY '#{node[:mysql][:server_repl_password]}';"}
    end
  end
  action :create
  only_if "mysql -u root -p#{node[:mysql][:server_root_password]} -e 'show databases;'"
end

# now we set up master stuff
if 1 > 2 #Replication should be set manually

  ruby_block "master-log" do
    block do
      logs = %x[mysql -u root -p#{node[:mysql][:server_root_password]} -e "show master status;" | grep mysql].strip.split
      node.default[:mysql][:server][:log_file] = logs[0]
      node.default[:mysql][:server][:log_pos] = logs[1]
      node.save
    end
    action :create
  end

  unless tagged?("replication-configured")
    ruby_block "import-master-log" do
      block do
        master_log_file = cluster_slaves.first[:mysql][:server][:logfile]
        master_log_pos = cluster_slaves.first[:mysql][:server][:log_pos]
        %x{mysql -u root -p#{node[:mysql][:server_root_password]} -e "CHANGE MASTER TO master_host='#{cluster_slaves.first[:ipaddress]}', master_port=3306, master_user='repl', master_password='#{cluster_slaves.first[:mysql][:server_repl_password]}', master_log_file='#{master_log_file}', master_log_pos=#{master_log_pos};"}
        %x{mysql -u root -p#{node[:mysql][:server_root_password]} -e "START SLAVE;"}
      end
      action :create
    end
    tag("replication-configured")
  end
end
