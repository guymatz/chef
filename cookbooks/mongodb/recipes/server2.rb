directory "#{node[:mongodb2][:pidfile_loc]}" do
  owner "mongod"
  group "mongod"
  mode 0755
  recursive true
  action :create
end

template "#{node[:mongodb2][:startup_script_name]}" do
        source "mongod.erb"
        owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb2]
        })
end

template "#{node[:mongodb2][:config_file_dir]}/#{node[:mongodb2][:config_file_name]}" do
	source "mongod.conf.erb"
	owner "root"
        group "root"
        mode 0755 
        variables({
                :mongodb => node[:mongodb2]
        })
end
