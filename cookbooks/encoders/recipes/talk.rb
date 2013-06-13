include_recipe "logrotate"

begin
  unless tagged?("talk-deployed")

    node[:encoders][:filemonitor][:talk_links].each do |target,src|
        link "#{target}" do
            to "#{src}"
        end
    end
    mixins_mount_line = "#{node[:encoders][:nfsserver]}:/nfs#{node[:encoders][:prn_export_dir]} #{node[:encoders][:prn_mount_dir]}       nfs   rw,vers=3,bg,soft,tcp,intr  0   0"

    execute "prn_dir" do
        command "mkdir -p #{node[:encoders][:prn_mount_dir]}"
        not_if { ::File.exists?("#{node[:encoders][:prn_mount_dir]}")}
    end

    append_if_no_line "prn_mount" do
        path "/etc/fstab"
        line prn_mount_line
        notifies :run, "execute[prn_dir]", :immediately
        notifies :run, "execute[mounts]", :immediately
    end

    execute "mounts" do
        command "/bin/mount -a"
        action :run
    end


   tag("talk-deployed")
   end
rescue
    untag("talk-deployed")
end
