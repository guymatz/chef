directory "/data" do
	owner "root"
	group "root"
	mode 0755
	action :create
end

mount "/data" do
	pass 0
	dump 0
	device "/dev/sdb1"
	fstype "ext4"
	options "rw,noatime,data=writeback,nobh"
	action [:mount, :enable]
end
