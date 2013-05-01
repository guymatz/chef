directory "#{node[:cfgmongodb][:cfgdata_dir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "/etc/init.d/cfgmongod" do
        source "cfgmongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
		:mongodb => node[:mongodb],
                :cfgmongodb => node[:cfgmongodb]
        })
end

template "/etc/cfgmongod.conf" do
	source "cfgmongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
		:mongodb => node[:mongodb],
                :cfgmongodb => node[:cfgmongodb]
        })
end
