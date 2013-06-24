begin
  unless tagged?("encoder-mounts")

    directory node[:encoders][:ftp_mount_dir] do
        owner "root"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:ftp_mount_dir]) end
    end

    directory node[:encoders][:p_content_dir] do
        owner "root"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:p_content_dir]) end
    end
    mount node[:encoders][:ftp_mount_dir] do
        device "#{node[:encoders][:isilon_server]}:#{node[:encoders][:ftp_mount_export]}"
        fstype "nfs"
        options "rw"
        action [:mount, :enable]
    end

    mount node[:encoders][:p_content_dir] do
        device "#{node[:encoders][:isilon_server]}:#{node[:encoders][:p_content_export]}"
        fstype "nfs"
        options "rw"
        action [:mount, :enable]
    end

    tag("encoder-mounts")
    end
rescue
    untag("encoder-mounts")
end
