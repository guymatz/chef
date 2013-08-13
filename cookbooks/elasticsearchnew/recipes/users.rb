deploy_keys = Chef::EncryptedDataBagItem.load("keys", "elasticsearch")
directory "/home/elasticsearch/.ssh" do
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  recursive true
  mode "0700"
end

file "/home/#{node[:elasticsearchnew][:user]}/.ssh/deploy" do
    owner node[:elasticsearchnew][:user]
    group node[:elasticsearchnew][:group]
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
  end

file "/home/#{node[:elasticsearchnew][:user]}/.ssh/config" do
  owner node[:elasticsearchnew][:user]
  group node[:elasticsearchnew][:group]
  mode "0755"
  content <<-EOH
  Host *github.com *.ihr iad-search*
    IdentityFile "/home/#{node[:elasticsearchnew][:user]}/.ssh/deploy"
    StrictHostKeyChecking no
EOH
end
