template "/etc/security/limits.d/membase.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({ :domain => node[:membase][:user],
               :ulimits => node[:membase][:ulimits]
            })
end
