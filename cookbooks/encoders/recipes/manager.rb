include_recipe "logrotate"


aladdin_mount_line = "#{node[:encoders][:nfsserver]}:/nfs#{node[:encoders][:aladdin_export_dir]} #{node[:encoders][:aladdin_mount_dir]}       nfs   rw,vers=3,bg,soft,tcp,intr  0   0"

execute "aladdin_dir" do
    command "mkdir -p #{node[:encoders][:aladdin_mount_dir]}"
        not_if { ::File.exists?("#{node[:encoders][:aladdin_mount_dir]}")}
end
append_if_no_line "aladdin_mount" do
    path "/etc/fstab"
    line aladdin_mount_line
    notifies :run, "execute[aladdin_dir]", :immediately
    notifies :run, "execute[mounts]", :immediately
end

execute "mounts" do
    command "/bin/mount -a"
    action :run
end

logrotate_app "jboss" do
    cookbook "logrotate"
    path "/data/jboss_4_0_5/server/ingestion/log"
    frequency "daily"
    rotate 4
    compress true
    create "644 root root"
end

