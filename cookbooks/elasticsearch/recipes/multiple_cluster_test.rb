my_cluster=node[:elasticsearch][:cluster_membership]


cluster_members = search(:node, "cluster_membership:#{mycluster}")
cluster_ips = Array.new
cluster_members.each do |s|
  cluster_ips << s[:ipaddress]
end

template "/root/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
  variables({
              :cluster_ips => cluster_ips
             })
end
