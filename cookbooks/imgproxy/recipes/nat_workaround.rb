# This recipe is used to set the hosts file on the imgproxys to get around
# Carpathia NAT issues.
node[:imgproxy][:host_entries].each do |ip, host|
  hostsfile_entry ip do
    hostname host
  end
end
