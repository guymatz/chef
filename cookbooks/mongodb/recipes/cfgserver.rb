include_attribute 'mongodb::cfgserver'

template "/etc/init.d/cfgmongod" do
        source "cfgmongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb]
        })
end

template "/etc/cfgmongod.conf" do
	source "cfgmongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:cfgmongodb]
        })
end
