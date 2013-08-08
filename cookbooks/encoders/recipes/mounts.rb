begin
  unless tagged?("encoder-mounts")

    directory node[:encoders][:p_encoder_mount] do
        owner "converter"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:p_encoder_mount]) end
    end
    mount node[:encoders][:p_encoder_mount] do
        device "#{node[:encoders][:isilon_server]}:#{node[:encoders][:p_encoder_export]}"
        fstype "nfs"
        options "rw,vers=3,bg,soft,tcp,intr"
        action [:mount, :enable]
    end

    directory node[:encoders][:p_ftp_mount] do
        owner "converter"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:p_ftp_mount]) end
    end

    mount node[:encoders][:p_ftp_mount] do
        device "#{node[:encoders][:isilon_server]}:#{node[:encoders][:p_ftp_export]}"
        fstype "nfs"
        options "rw,vers=3,bg,soft,tcp,intr"
        action [:mount, :enable]
    end

# legacy links
    node[:encoders][:filemonitor][:ingestion_links].each do |target,src|
        link target do
            to src
        end
    end

    tag("encoder-mounts")
    end
rescue
    untag("encoder-mounts")
end
