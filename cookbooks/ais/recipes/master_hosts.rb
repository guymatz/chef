# Setup the master server aliases on an edge

master_nodes = search(:node, "role:#{node[:ais][:master_role]}").sort!
master_pos = 0

begin
  node[:ais][:master_aliases].each do |x|
    hostsfile_entry master_nodes[master_pos][:ipaddress] do
      hostname  x
    end
    master_pos += 1
  end
rescue
  Chef::Log.info('Could not update the hosts file.')
end
