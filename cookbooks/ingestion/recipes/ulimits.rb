# Setup postgres ulimits

template "/etc/security/limits.d/postgres.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variable ({ :domain => node[:postgres][:user],
	      :ulimits => node[:postgres][:ulimits]
            })
end
