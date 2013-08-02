
users_manage "ihr-deployer" do
  group_id 4007
  action [:remove, :create]
end

sudo "ihr-deployer" do
  group "ihr-deployer"
  commands [
             "/bin/rm -f /data/apps/tomcat7/logs/event.log.*",
             "/bin/rm -f /data/apps/tomcat7/logs/sysinfo.log.*",
           ]
  runas "root"
  nopasswd true
end

sudo "amqp-consumer" do
  group "ihr-deployer"
  commands [
             "/bin/tar zcvPf /data/log/enrichment-consumer/enrichmentMisses.txt.* *",
	     "/bin/rm /data/log/enrichment-consumer/enrichmentMisses.txt.*"
  ]
  runas "amqp-consumer"
  nopasswd true
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

file "/home/ihr-deployer/.hushlogin" do
  owner "ihr-deployer"
  group "ihr-deployer"
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
  Host *
    IdentityFile "/home/ihr-deployer/.ssh/id_rsa"
    StrictHostKeyChecking no
EOH
end
