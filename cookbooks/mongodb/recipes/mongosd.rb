node[:mongodb][:packages].each do |mongo_pkg|
  yum_package mongo_pkg do
    arch nil
  end
end


directory "#{node[:mongosd][:mongosdata_dir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "/etc/init.d/mongosd" do
  source "mongosd.erb"
  owner "root"
  group "root"
  mode 0755
  variables({
              :mongodb => node[:mongodb],
              :mongosd => node[:mongosd]
            })
end

template "/etc/mongosd.conf" do
  source "mongosd.conf.erb"
  owner "root"
  group "root"
  mode 0755
  variables({
              :mongodb => node[:mongodb],
              :mongosd => node[:mongosd]
            })
end
