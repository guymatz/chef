directory "#{node[:arbmongodb][:arbdata_dir]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

directory "#{node[:arbmongodb][:arbpidfile_loc]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "/etc/init.d/arbmongod" do
        source "arbmongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
		:mongodb => node[:mongodb],
                :arbmongodb => node[:arbmongodb]
        })
end

template "/etc/arbmongod.conf" do
	source "arbmongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
		:mongodb => node[:mongodb],
                :arbmongodb => node[:arbmongodb]
        })
end
