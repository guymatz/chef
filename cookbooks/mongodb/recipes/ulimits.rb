template "/etc/security/limits.d/mongodb.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({ :domain => node[:mongodb][:user],
               :ulimits => node[:mongodb][:ulimits]
            })
end
