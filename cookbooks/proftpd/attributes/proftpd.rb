default[:proftpd][:encoder_export]       = "iad-isilon001.ihr:/ifs/encoder/encoder"
default[:proftpd][:encoder_mount_point]  = "/data/encoder"
default[:proftpd][:dir]                  = "/etc/proftpd"
default[:proftpd][:key_dir]              = "/etc/proftpd/authorized_keys"
default[:proftpd][:dir_extra_conf]       = "conf.d"
default[:proftpd][:nat]                  = "off"
default[:proftpd][:server_name]          = "NULL"
default[:proftpd][:email_admin]          = node[:admin_email]
default[:proftpd][:ftp_user]             = "vftp"
default[:proftpd][:ftp_group]            = "vftp"
default[:proftpd][:conv_user]            = "converter"
default[:proftpd][:conv_group]           = "converter"
default[:proftpd][:uid]                  = 999
default[:proftpd][:max_instances]        = 30
default[:proftpd][:max_clients_per_host] = 4
default[:proftpd][:timeout_no_transfer]  = 600
default[:proftpd][:timeout_stalled]      = 600
default[:proftpd][:timeout_idle]         = 1200
default[:proftpd][:rfc2228]              = "on"
default[:proftpd][:reverse_dns]          = "off"
default[:proftpd][:sendfile]             = "off"
default[:proftpd][:ident_lookups]        = "off"
default[:proftpd][:system_log]           = "/var/log/proftpd/proftpd.log"
default[:proftpd][:transfer_log]         = "/var/log/proftpd/xferlog"
default[:proftpd][:defer_welcome]        = "on"
default[:proftpd][:allow_overwrite]      = "on"
default[:proftpd][:umask]                = "007 007"
default[:proftpd][:list_options]         = "-l"
default[:proftpd][:show_symlinks]        = "on"
default[:proftpd][:require_valid_shell]  = "off"
default[:proftpd][:dir_fakegroup]        = "myself"
default[:proftpd][:dir_fakegroup]        = "ftp_users"
default[:proftpd][:default_root]         = "/data/ftp"
default[:proftpd][:default_shell]        = "/bin/bash"
default[:proftpd][:user_file]            = default[:proftpd][:dir] + "/ftpd.passwd"
default[:proftpd][:data_bag]             = "music_upload"
default[:proftpd][:data_item]            = "upload_user-keys"
default[:proftpd][:port]                 = 21
default[:proftpd][:default_address]      = ipaddress
default[:proftpd][:modules]              = [
  "ctrls",
  "ctrls_admin",
  "ban",
  "load",
#  "dynmasq",
  "ifsession",
  "quotatab",
  "quotatab_file",
  "sftp"
]

sql = proftpd[:modules].select { |m| m =~ /sql_./ }
unless sql.empty?
  set[:proftpd][:sql]      = "on"
else
  set[:proftpd][:sql]      = "off"
end
