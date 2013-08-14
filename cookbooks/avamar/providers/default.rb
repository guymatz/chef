

# initializes a new host for avamar backups
action :init do 
	# t=node.tags.select {|i| i =~ /avamar_initialized/}
	unless node.tags.include? "avamar_initialized"
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
		
	else 
		Chef::Log.info("Host has already been initialized")

	end
end

# register a new host with avamar system
action :register do 
	puts "REGISTERING! Resource name is #{new_resource.name}"
end