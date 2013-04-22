#
# Cookbook Name:: encoder
# Recipe:: ftp server
#
# Copyright 2013, iheartradio / clear channel
#
# All rights reserved - Do Not Redistribute
#

ftp_mount_line = "#{node[:encoders][:nfsserver]}:/nfs#{node[:encoders][:ftp_mount]} #{node[:encoders][:ftp_mount]}       nfs   rw,vers=3,bg,soft,tcp,intr  0   0"

execute "mkdirs" do
    command "mkdir -p #{node[:encoders][:ftp_mount]}"
    not_if { ::File.exists?("#{node[:encoders][:ftp_mount]}")}
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
          not_if { node.normal.attribute?("encoder_deployed") }
    end
end



# Get our encrypted data
users = Chef::EncryptedDataBagItem.load("music_upload", "upload_users").to_hash

users.each do |k,v|
    next if k == "id"
    bash "tt" do
    code <<-EOF
        "echo #{k} >> /etc/vsftpd/vuser/music_users.txt"
        "echo #{v["password"]} >> /etc/vsftpd/vuser/music_users.txt"
       # echo #{k}
       # echo #{v["password"]}
    EOF
    end
    bash "createdb" do
    code <<-EOF
        /usr/bin/db_load -T -t hash -f /etc/vsftpd/vuser/music_vusers.txt /etc/vsftpd/vuser/music_vusers.db
        #rm -f /etc/vsftpd/vuser/music_vusers.txt
    EOF
    end
end

append_if_no_line "sftp" do
    path "/etc/ssh/sshd_config"
    line "Subsystem sftp /usr/libexec/openssh/sftp-server"
end
