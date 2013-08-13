default[:avamar] ||= {};
default[:avamar][:server_ip] 		= "172.31.0.30";
default[:avamar][:server_fqdn] 		= "va3autp-car001.ops.servervault.com";
default[:avamar][:server_alias] 	= "va3autp-car001";
default[:avamar][:register_xcmd] 	= "/usr/local/avamar/bin/avregister";
default[:avamar][:client_domain]	= "/iheartradio";
default[:avamar][:app_dir] 			= "/usr/local/avamar";
default[:avamar][:bin_dir]			= "#{default[:avamar][:app_dir]}/bin";
default[:avamar][:cmd_register]		= "#{default[:avamar][:bin_dir]}/avregister";
default[:avamar][:cmd_backup]		= "#{default[:avamar][:bin_dir]}/avtar";
default[:avamar][:cmd_backup]		= "#{default[:avamar][:bin_dir]}/avtar";


default[:avamar][:default_backup_dir = "/data/backups"