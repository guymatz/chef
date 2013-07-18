user node[:elasticsearch][:user] do
  comment "Elastic Search Service Account"
  shell "/sbin/nologin"
end

deploy_keys = Chef::EncryptedDataBagItem.load("keys", "elasticsearch")
directory "/home/elasticsearch/.ssh" do
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
  recursive true
  mode "0700"
end

file "/home/#{node[:elasticsearch][:user]}/.ssh/deploy" do
    owner node[:elasticsearch][:user]
    group node[:elasticsearch][:group]
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
  end

file "/home/#{node[:elasticsearch][:user]}/.ssh/config" do
  owner node[:elasticsearch][:user]
  group node[:elasticsearch][:group]
  mode "0755"
  content <<-EOH
  Host *github.com *.ihr iad-search*
    IdentityFile "/home/#{node[:elasticsearch][:user]}/.ssh/deploy"
    StrictHostKeyChecking no
EOH
end
