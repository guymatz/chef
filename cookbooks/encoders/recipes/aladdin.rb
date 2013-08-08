####
### JPD Wed Aug  7 18:22:19 UTC 2013
### Recipe specific for aladdin transcoding, currently on iad-enc101
###

begin
    unless tagged?("aladdin")

    directory node[:aladdin][:aladdin_mount_dir] do
        owner "root"
        group "root"
        not_if do FileTest.directory?([:aladdin][:aladdin_mount_dir]) end
    end

    mount node[:encoders][:p_encoder_mount] do
        device "#{node[:encoders][:isilon_server]}:#{node[:encoders][:p_encoder_export]}"
        fstype "nfs"
        options "rw,vers=3,bg,soft,tcp,intr"
        action [:mount, :enable]

    tag("aladdin")
    end
rescue
    untag("alddin")
end
