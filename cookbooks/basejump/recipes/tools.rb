
app_secrets = Chef::EncryptedDataBagItem.load("secrets", "drac")

%w{ ipmitool }.each do |dep|
  package dep
end

%w{ consoleto poweron poweroff rebooter }.each do |s|
  template "/usr/sbin/#{s}" do
    source "#{s}.sh.erb"
    owner "root"
    group "root"
    mode "0700"
    variables({
                :ipmi_user => app_secrets['username'],
                :ipmi_pass => app_secrets['password']
              })
  end
end
