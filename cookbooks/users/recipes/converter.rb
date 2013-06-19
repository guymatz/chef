
users_manage "converter" do
  group_id 2306
  action [ :remove, :create ]
end

users_manage "prn-transcoding" do
  group_id 700
  action [ :remove, :create ]
end

users_manage "mixins-transcoding" do
  group_id 705
  action [ :remove, :create ]
end

users_manage "talk-transcoding" do
  group_id 702
  action [ :remove, :create ]
end

sudo "converter" do
  group "converter"
  commands ["ALL"]
  runas "root"
  nopasswd true
end


# drop a github private deploy key for converter
deploy_keys = Chef::EncryptedDataBagItem.load("keys", "encoder-deploy")

directory "/home/converter/.ssh" do
    owner node[:encoders][:user]
    group node[:encoders][:group]
    recursive true
    mode "0700"
end

file "/home/converter/.ssh/id_deploy" do
    owner node[:encoders][:user]
    group node[:encoders][:group]
    mode "0400"
    content deploy_keys['private_key']
    :create_if_missing
end

file "/home/converter/.ssh/config" do
    owner node[:encoders][:user]
    group node[:encoders][:group]
    mode "0755"
    content <<-EOH
        Host *github.com
        IdentityFile "/home/converter/.ssh/id_deploy"
        StrictHostKeyChecking no
    EOH
end
