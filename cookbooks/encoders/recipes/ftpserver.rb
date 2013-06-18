#
# Cookbook Name:: encoder
# Recipe:: ftp server
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#


begin
  unless tagged?("encoder-ftp-deployed")
    ftp_mount_line = "#{node[:encoders][:nfsserver]}:/nfs#{node[:encoders][:ftp_mount]} #{node[:encoders][:ftp_mount]}       nfs   rw,vers=3,bg,soft,tcp,intr  0   0"


    service "vsftpd" do
        action [ :nothing ]
        supports :status => true, :start => true, :stop => true, :restart => true
    end

    execute "mkdirs" do
        command "mkdir -p #{node[:encoders][:ftp_mount]}"
    end

    execute "mounts" do
        command "/bin/mount -a"
        action :run
    end

    append_if_no_line "encoder_ftp" do
        path "/etc/fstab"
        line ftp_mount_line
        notifies :run, "execute[mkdirs]", :immediately
        notifies :run, "execute[mounts]", :immediately
    end

    node[:ftpserver].each do |pkg|
        yum_package pkg do
              arch "x86_64"
        end
    end

    template "/etc/vsftpd/vuser/music_users.txt" do
        source "music_users.txt"
        owner "root"
        group "root"
        mode 0400
    end


##
## Not the most elegant parsing of the databag, but this shows my inexperience in ruby
## need to clean it up.
## JPD

# Get our encrypted data
    users = Chef::EncryptedDataBagItem.load("music_upload", "upload_users").to_hash

    users.each do |k,v|
        next if k == "id"
        v.each do |dis, pw|
            bash "keys" do
                code <<-EOF
                    echo "#{k}" >> /etc/vsftpd/vuser/music_users.txt
                    echo "#{pw}" >> /etc/vsftpd/vuser/music_users.txt
#                    if [ ! -d #{node[:encoders][:ftp_mount]}/#{k} ]
#                    then
#                        mkdir #{node[:encoders][:ftp_mount]}/#{k}
#                        chmod 2775 #{node[:encoders][:ftp_mount]}/#{k}
#                        chown #{node[:encoders][:ftpuser]} #{node[:encoders][:ftp_mount]}/#{k}
#                        chgrp #{node[:encoders][:group]} #{node[:encoders][:ftp_mount]}/#{k}
#                    fi
                EOF
            end
        end
    end

    bash "createdb" do
        code <<-EOF
            /usr/bin/db_load -T -t hash -f /etc/vsftpd/vuser/music_users.txt /etc/vsftpd/vuser/music_vusers.db
            rm -f /etc/vsftpd/vuser/music_users.txt
        EOF
    end


    append_if_no_line "sftp" do
        path "/etc/ssh/sshd_config"
        line "Subsystem sftp /usr/libexec/openssh/sftp-server"
    end

    service "vsftpd" do
       action [:enable, :start ]
    end

    service "incrond" do
            action [:enable, :start]
    end

    tag("encoder-ftp-deployed")
    end
rescue
    untag("encoder-ftp-deployed")
end
