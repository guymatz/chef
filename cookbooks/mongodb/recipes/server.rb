#mount node[:mongodb][:data_dir] do
#  device node[:mongodb][:data_device]
#  fstype "ext4"
#  action [:mount, :enable]
#end

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
