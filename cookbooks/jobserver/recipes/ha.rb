require 'socket'


include_recipe "heartbeat"

node[:fqdn] =~ /(\w*-\w*\d*)(a|b)(\..*)$/
vip_hostname = $1 + $3
vip_ip = IPSocket::getaddress(vip_hostname)

# for now we can assume a /23, but we can keep a data bag to look these up, if needed
vip_netmask = '255.255.254.0'

if $2 == 'a'
  partner_hostname = $1 + 'b' + $3
  local_ha_ip = '172.16.0.1'
  partner_ha_ip = '172.16.0.2'
else
  partner_hostname = $1 + 'a' + $3
  local_ha_ip = '172.16.0.2'
  partner_ha_ip = '172.16.0.1'
end

partner_ip = IPSocket::getaddress(partner_hostname)

# figure out if we're vmware or physical
# vmware will always use eth1 for the HA-link
# physicals will always use em2 for the HA-Link

if node.has_key?('virtualization')
  if node['virtualization'].has_key?('system')
    if node['virtualization']['system'].include? 'vmware'
      host_type = 'vmware'
      ha_intf = 'eth1'
      attach_to = 'eth0'
    else
      host_type = 'physical'
      ha_intf = 'em2'
      attach_to = 'em1'
    end
  end
end

ifconfig "#{local_ha_ip}" do
  device "#{ha_intf}"
end

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
Chef::Log.info("Checking HB Authkeys")
if node['heartbeat']['config']['authkeys'].nil?
  genkey = true
  Chef::Log.info("No Authkey Found")
  Chef::Log.info("Missing authkeys, searching for other nodes that might have one")
  # This node doesn't have a key, but maybe the other one(s) do
  Chef::Log.info("SEARCH: roles:jobserver AND chef_environment:#{node.chef_environment}")
  search(:node, "roles:jobserver AND chef_environment:#{node.chef_environment}").each do |js|
    Chef::Log.info("checking for key on #{node['fqdn']}")
    unless js['heartbeat']['config']['authkeys'].nil?
      Chef::Log.info("Found a key to use on #{js['fqdn']}")
      node.set['heartbeat']['config']['authkeys'] = js['heartbeat']['config']['authkeys']
      node.save
      genkey = false
      break
    end
  end
  if genkey
    Chef::Log.info("No keys found on other node, generating secure key")
    # could not find a key, let's make one
    node.set_unless['heartbeat']['config']['authkeys'] = secure_password
    node.save
  end
end

ha_resources = Array.new
ha_resources.push("IPaddr::#{vip_ip}/#{vip_netmask}/#{attach_to}")
begin
  node[:jobserver][:ha_resources].each do |r|
    ha_resources.push(r)
  end
  rescue NoMethodError
end

heartbeat "jobserver" do
  auto_failback false
  autojoin "none"
  # compression
  # compression_threshold
  deadtime 180
  initdead 180
  keepalive 2
  logfacility "local0"
  authkeys node[:heartbeat][:config][:authkeys]
  # udpport
  warntime 15
  search "chef_environment:#{node.chef_environment} AND roles:jobserver"
  interface ha_intf
  # mcast_group
  # mcast_ttl
  mode "ucast"
  resource_groups ha_resources
end
