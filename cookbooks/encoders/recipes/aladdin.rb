####
### JPD Wed Aug  7 18:22:19 UTC 2013
### Recipe specific for aladdin transcoding, currently on iad-enc101
###

begin
    unless tagged?("aladdin")

    directory node[:aladdin][:aladdin_mount_dir] do
        owner "root"
        group "root"
        #not_if do FileTest.directory?([:aladdin][:aladdin_mount_dir]) end
    end

    mount node[:aladdin][:aladdin_mount_dir] do
        device "#{node[:aladdin][:nfs_server]}:#{node[:aladdin][:aladdin_export_dir]}"
        fstype "nfs"
        options "rw,vers=3,bg,soft,tcp,intr"
        action [:mount, :enable]
    end

    cron_d "aladdin_prod_transcoder" do
        command "/data/aladdin/aladdin_prod_transcoder.sh >> /var/log/aladdin_prod_transcoder.log 2>&1"
        minute  "*/5"
        hour  "*"
        day   "*"
        month   "*"
        weekday "*"
        user "root"
    end

    cron_d "aladdin_prod_rsync" do
        command "/root/prod-aladdin-rsync/rsync-prod-aladdin.sh  >/dev/null 2>&1"
        minute  "*/5"
        hour  "*"
        day   "*"
        month   "*"
        weekday "*"
        user "root"
    end

    tag("aladdin")
    end
rescue
    untag("aladdin")
end
