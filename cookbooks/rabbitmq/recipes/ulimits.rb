template "/etc/security/limits.d/attivio.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               :domain => 'rabbitmq',
               :ulimits => node[:attivio][:ulimits]
             })
end
