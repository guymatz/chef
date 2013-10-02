mount "/data" do
	pass 0
	fstype "ext4"
	device "/dev/mapper/centos-data"
	options "noatime,data=writeback"
	action [:mount, :enable]
end
