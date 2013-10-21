mount node[:mongodb][:data_mount_point] do
  device node[:mongodb][:data_device]
  fstype "ext4"
  action [:mount, :enable]
end

include_recipe "users::mongodb"

directory "#{node[:mongodb][:pidfile_loc]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "#{node[:mongodb][:startup_script_name]}" do
        source "mongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb]
        })
end

template "#{node[:mongodb][:config_file_dir]}/#{node[:mongodb][:config_file_name]}" do
	source "mongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb]
        })
end
