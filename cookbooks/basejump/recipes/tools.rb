
app_secrets = Chef::EncryptedDataBagItem.load("secrets", "drac")

template "/usr/sbin/consoleto" do
  source "consoleto.sh.erb"
  owner "root"
  group "root"
  mode "0700"
  variables({
              :ipmi_user => app_secrets['username'],
              :ipmi_pass => app_secrets['password']
            })
end
