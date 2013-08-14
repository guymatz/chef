

# initializes a new host for avamar backups
action :init do 
	unless node.tags.include? "avamar_initialized"
		Chef::Log.info("Registering host #{new_resource.name}")

		# install the client rpm
		yum_package "AvamarClient" do
			arch "x86_64"
			action :install
		end

		# add an entry for the server in the hosts file
		hostsfile_entry node[:avamar][:server_ip] do
			hostname node[:avamar][:server_fqdn]
			aliases [ node[:avamar][:server_alias] ]
			action :append
		end

		# set up default backup directory
		unless FileTest.directory?(node[:avamar][:default_dir])
			directory node[:avamar][:default_dir] do
				owner node[:avamar][:default_user]
				group node[:avamar][:default_group]
				action :create
			end

		else 
			Chef::Log.info("Default Directory already exists")

		end

		node.tags << "avamar_initialized"
	Chef::Log.info("Initialized host #{new_resource.name}")

	else 
		Chef::Log.info("Host #{new_resource.name} has already been initialized")

	end
end

# register a new host with avamar system
action :register do 
	unless node.tags.include? "avamar_registered"
		Chef::Log.info("Registering host #{new_resource.name}")

		Chef::Log.info("Reg command is: #{node[:avamar][:cmd_register]}")

		execute "register_avamar_node" do
			command "#{node[:avamar][:cmd_register]}"
			group "root"
			user "root"
			action :run
		end

		node.tags << "avamar_initialized"
		Chef::Log.info("Registered host #{new_resource.name}")

	else 
		Chef::Log.info("Host #{new_resource.name} has already been registered")

	end
end