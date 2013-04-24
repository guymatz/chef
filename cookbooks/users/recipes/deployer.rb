
users_manage "ihr-deployer" do
  group_id 4007
  action [:remove, :create]
end

deploy_keys = Chef::EncryptedDataBagItem.load("keys", "ihrdeployer")

directory "/home/ihr-deployer/.ssh" do
  owner "ihr-deployer"
  group "ihr-deployer"
  recursive true
end

file "/home/ihr-deployer/.ssh/id_rsa" do
  owner "ihr-deployer"
  group "ihr-deployer"
  mode "0400"
  content deploy_keys['private_key']
  :create_if_missing
end

file "/root/.ssh/config" do
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
  Host *github.com
    User ihr-deployer
    IdentityFile "/home/ihr-deployer/.ssh/id_rsa"
    StrictHostKeyChecking no
EOH
end

file "/home/ihr-deployer/.ssh/config" do
  owner "ihr-deployer"
  group "ihr-deployer"
  mode "0755"
  content <<-EOH
  Host *github.com
    IdentityFile "/home/ihr-deployer/.ssh/id_rsa"
    StrictHostKeyChecking no
EOH
end
