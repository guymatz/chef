






template "/etc/security/limits.d/elasticsearch.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               :domain => node[:elasticsearch][:user],
               :ulimits => node[:elasticsearch][:ulimits]
             })
end
