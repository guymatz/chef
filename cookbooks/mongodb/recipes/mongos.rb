include_attribute 'mongodb::mongosd'

directory "#{node[:mongosd][:mongospidfile_loc]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "/etc/init.d/mongosd" do
        source "mongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongosd]
        })
end

template "/etc/mongosd.conf" do
	source "mongosd.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongosd]
        })
end
