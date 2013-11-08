include_recipe "users::mongodb"

directory "#{node[:mongodb][:pidfile_loc]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "/etc/init.d/mongod" do
        source "mongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb]
        })
end

template "/etc/mongod.conf" do
	source "mongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb]
        })
end
