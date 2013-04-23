include_recipe "users::attivio"

user node[:attivio][:user] do
  comment "Attivio Service Account"
  shell "/bin/bash"
end

# drop a github private deploy key for attivio
deploy_keys = Chef::EncryptedDataBagItem.load("keys", "attivio")
directory "/home/attivio/.ssh" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  recursive true
  mode "0700"
end

file "/home/#{node[:attivio][:user]}/.ssh/deploy" do
    owner node[:attivio][:user]
    group node[:attivio][:group]
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
  end

file "/home/#{node[:attivio][:user]}/.ssh/config" do
  owner node[:attivio][:user]
  group node[:attivio][:group]
  mode "0755"
  content <<-EOH
  Host *github.com *.ihr iad-search*
    IdentityFile "/home/#{node[:attivio][:user]}/.ssh/deploy"
    StrictHostKeyChecking no
EOH
end

