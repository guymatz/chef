my_cluster=node[:elasticsearchnew][:cluster_membership]


cluster_members = search(:node, "cluster_membership:#{my_cluster}")
cluster_ips = Array.new
cluster_members.each do |s|
  cluster_ips << s[:ipaddress]
end

template "/root/elasticsearchnew.yml" do
  source "elasticsearchnew.yml.erb"
  owner "root"
  group "root"
  variables({
              :cluster_ips => cluster_ips
             })
end
