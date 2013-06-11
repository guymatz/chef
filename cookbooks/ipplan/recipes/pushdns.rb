results = search(:node, "recipes:bind-chroot")
dns_servers = Array.new
results.each do |r|
  dns_servers << r["fqdn"]
end
result = search(:node, "role:ipplan")
ipplan_host = result[0]["fqdn"]

template "/usr/local/bin/push-dns" do
  source "push-dns.sh.erb"
  owner "root"
  group "root"
  mode "0755"
  variables({
              :scripts_dir => node[:ipplan][:scripts_dir],
              :dns_servers => dns_servers,
              :ipplan_host => ipplan_host
            })
end
