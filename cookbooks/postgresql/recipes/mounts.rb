mount "/data" do
	pass 0
	fstype "ext4"
	device "/dev/mapper/mpathbp1"
	options "noatime,data=writeback"
	action [:mount, :enable]
end
