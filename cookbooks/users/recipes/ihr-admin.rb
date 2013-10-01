
# ihr-deployer is in sysadmin group, so it gets created elsewhere, and
# has all privs in sudo

deploy_keys = Chef::EncryptedDataBagItem.load("keys", "ihradmin")

directory "/home/ihr-admin/.ssh" do
  owner "ihr-admin"
  group "ihr-admin"
  recursive true
end

file "/home/ihr-admin/.ssh/id_rsa" do
  owner "ihr-admin"
  group "ihr-admin"
  mode "0400"
  content deploy_keys['private_key']
  :create_if_missing
end

file "/home/ihr-admin/.hushlogin" do
  owner "ihr-admin"
  group "ihr-admin"
  :create_if_missing
end

directory "/root/.ssh" do
  mode 0600
end

file "/home/ihr-admin/.ssh/config" do
  owner "ihr-admin"
  group "ihr-admin"
  mode "0755"
  content <<-EOH
  Host *
    IdentityFile "/home/ihr-admin/.ssh/id_rsa"
    StrictHostKeyChecking no
EOH
end
