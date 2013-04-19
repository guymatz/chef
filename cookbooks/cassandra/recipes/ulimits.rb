template "/etc/security/limits.d/cassandra.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({ :domain => node[:cassandra][:user],
               :ulimits => node[:cassandra][:ulimits]
            })
end

template "/etc/security/limits.d/cassandra_root.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({ :domain => "root",
               :ulimits => node[:cassandra][:root_ulimits]
            })
end
