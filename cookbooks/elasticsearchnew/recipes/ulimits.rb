






template "/etc/security/limits.d/elasticsearch.conf" do
  source "limits.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables ({
               :domain => node[:elasticsearchnew][:user],
               :ulimits => node[:elasticsearchnew][:ulimits]
             })
end
