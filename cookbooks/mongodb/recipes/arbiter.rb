include_attribute 'mongodb::arbmongod'

template "/etc/init.d/arbmongod" do
        source "mongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:arbmongodb]
        })
end

template "/etc/arbmongod.conf" do
	source "mongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:arbmongodb]
        })
end
