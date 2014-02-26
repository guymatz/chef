begin
  unless tagged?("encoder-mounts")

    directory node[:encoders][:s_encoder_mount] do
        owner "converter"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:s_encoder_mount]) end
    end
    mount node[:encoders][:s_encoder_mount] do
        device "#{node[:encoders][:stage_server]}:#{node[:encoders][:s_encoder_export]}"
        fstype "nfs"
        options "rw,vers=3,bg,soft,tcp,intr"
        action [:mount, :enable]
    end

    directory node[:encoders][:s_ftp_mount] do
        owner "converter"
        group "converter"
        not_if do FileTest.directory?(node[:encoders][:s_ftp_mount]) end
    end

    mount node[:encoders][:s_ftp_mount] do
        device "#{node[:encoders][:stage_server]}:#{node[:encoders][:s_ftp_export]}"
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
