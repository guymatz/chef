include_attribute 'mongodb::mongosd'

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
