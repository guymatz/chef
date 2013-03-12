mount "/data" do
	pass 0
	fstype "ext4"
	device "/dev/mapper/mpathb1"
	options "noatime,data=writeback"
	action [:mount, :enable]
end
