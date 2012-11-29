# Create special device files
script "create_special_device_files" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  mknod #{node[:bind_chroot][:chroot_dir]}/dev/null c 1 3
  mknod #{node[:bind_chroot][:chroot_dir]}/dev/random c 1 8
  chmod 660 #{node[:bind_chroot][:chroot_dir]}/dev/{null,random}
  EOH
  not_if "ls #{node[:bind_chroot][:chroot_dir]}/dev/null |grep null"
end


# Edit PIDFILE var in /etc/init.d/<bind9|named>
bash "set_PIDFILE_environment_variable" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  echo -e >> /etc/profile
  echo "# Set PIDFILE environment variable" >> /etc/profile
  echo "export PIDFILE=#{node[:bind_chroot][:chroot_dir]}/var/run/named/named.pid" >> /etc/profile
  . /etc/profile
  EOH
  not_if "cat /etc/profile |grep PIDFILE"
end

# Tell rsyslog where the bind logs are
bash "tell_rsyslog_about_bind_logs" do
  user "root"
  cwd "tmp"
  code <<-EOH
  echo "\$AddUnixListenSocket #{node[:bind_chroot][:chroot_dir]}/dev/log" > /etc/rsyslog.d/bind-chroot.conf
  EOH
  not_if "cat /etc/rsyslog.d/bind-chroot.conf |grep chroot"
end

# Set permissions on jail
bash "set_permissions_on_chroot_jail" do
  user "root"
  cwd "tmp"
  code <<-EOH
  chown #{node[:bind_chroot][:bind_user_name]}:#{node[:bind_chroot][:bind_user_name]} -R #{node[:bind_chroot][:chroot_dir]}
  EOH
  only_if "ls -al #{node[:bind_chroot][:chroot_dir]}/var/ |grep root"
end

