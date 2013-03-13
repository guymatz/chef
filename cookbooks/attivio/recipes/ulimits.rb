






template "/etc/init.d/security/limits.d/attivio.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               domain => node[:ativio][:user],
               ulimits => node[:attivio][:ulimits]
             })
end
