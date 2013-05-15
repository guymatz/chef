






template "/etc/security/limits.d/facebook.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               :domain => node[:tomcat7][:user],
               :ulimits => node[:facebook][:ulimits]
             })
end
