default[:avamar] ||= {};
default[:avamar][:server_ip] 		= "172.31.0.30";
default[:avamar][:server_fqdn] 		= "va3autp-car001.ops.servervault.com";
default[:avamar][:server_alias] 	= "va3autp-car001";
default[:avamar][:register_xcmd] 	= "/usr/local/avamar/bin/avregister";
default[:avamar][:client_domain]	= "iheartradio";
default[:avamar][:app_dir] 			= "/usr/local/avamar";
default[:avamar][:bin_dir]			= "#{default[:avamar][:app_dir]}/bin";
default[:avamar][:etc_dir]			= "#{default[:avamar][:app_dir]}/etc";
default[:avamar][:cmd_register]		= "#{default[:avamar][:etc_dir]}/avagent.d register #{default[:avamar][:server_ip]} #{default[:avamar][:client_domain]}";
default[:avamar][:cmd_backup]		= "#{default[:avamar][:bin_dir]}/avtar";


default[:avamar][:default_dir] = "/data/av_bakup"
default[:avamar][:default_user] = "root"
default[:avamar][:default_group] = "root"

default[:avamar][:tag_initialized] = "avamar_initialized"
default[:avamar][:tag_registered] = "avamar_registered"