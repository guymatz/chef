users_manage "jenkins" do
  group_id 2323
  action [ :remove, :create ]
end

deploy_keys = Chef::EncryptedDataBagItem.load("keys", "ihrdeployer")

directory "/var/lib/jenkins/.ssh" do
  owner "jenkins"
  group "jenkins"
  recursive true
end

file "/var/lib/jenkins/.ssh/id_rsa_ihr_deployer" do
  owner "jenkins"
  group "jenkins"
  mode "0400"
  content deploy_keys['private_key']
  :create_if_missing
end

file "/var/lib/jenkins/.hushlogin" do
  owner "jenkins"
  group "jenkins"
  :create_if_missing
end

directory "/root/.ssh" do
  mode 0600
end

file "/root/.ssh/config" do
  owner "root"
  group "root"
  mode "0755"
  content <<-EOH
  Host *github*.com
    User jenkins
    IdentityFile "/var/lib/jenkins/.ssh/id_rsa"
    StrictHostKeyChecking no
EOH
end

file "/var/lib/jenkins/.ssh/config" do
  owner "jenkins"
  group "jenkins"
  mode "0755"
  content <<-EOH
  Host *github*.com
    IdentityFile "/var/lib/jenkins/.ssh/id_rsa_ihr_deployer"
    StrictHostKeyChecking no
EOH
end
