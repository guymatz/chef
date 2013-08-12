#Place where application will live

# RPM's we need 
default[:pkgs686] = [  'libtool-ltdl-devel', 'alsa-lib',  'ncurses-libs', 'ncurses-devel', 'glibc', 'alsa-lib', 'libgcc', 'compat-libstdc++-33' ]
default[:pkgsx64] = [ 'libxml2', 'zlib', 'zlib-devel', 'libxml2-devel', 'libxslt', 'libxslt-devel' ]
# Iheart RPMS
default[:iheart_pkg] = [ 'jdk', 'mpg123',  'lame-libs', 'libmad-devel', 'libmad'  ]
default[:ftpserver] = [ 'vsftpd', 'inotify-tools', 'inotify-tools-devel', 'incron' ]

# vantrix rpm, specific to iad-vantrix101 for now
default[:vantrix] = [ 'spotxde-trx' ]


# Tons of specific gems for all the encoders
default[:jruby_gems] =  {
     "ruby-mp3info" => "0.7.1",
     "activerecord-jdbc-adapter" => "1.2.2",
     "jdbc-postgres" => "9.1.901",
     "activerecord-jdbcpostgresql-adapter" => "1.2.2",
     "tmail" => "1.2.7.1",
     "nokogiri" => "1.4.0",
     "rake" => "0.8.7",
     "uits" => "0.0.0",
     "bouncy-castle-java" => "1.5.0146.1",
     "jruby-openssl" => "0.7.7",
     "spoon" => "0.0.1",
     "bundler" => "1.1.5"
}

default[:gems] = {
    "akamai" => "0.2.0",
    "ffi" => "1.2.0",
    "postgres-pr" => "0.6.3",
    "nori" => "2.0.4",
    "rack" => "1.5.2",
    "rails" => "3.2.13",
    "httpi" => "2.0.2",
    "wasabi" => "2.5.0",
    "builder" => "3.2.0",
    "gyoku" => "1.0.0",
    "savon" => "1.2.0",
    "libxml-ruby" => "2.6.0",
    "uits" => "0.0.0",
    "activerecord-jdbc-adapter" => "1.2.2",
    "activerecord-jdbcpostgresql-adapter" => "1.2.2",
    "bouncy-castle-java" => "1.5.0146.1",
    "bundler" => "1.1.5",
    "jdbc-postgres" => "9.1.901",
    "jruby-openssl" => "0.7.7",
    "nokogiri" => "1.4.0",
    "rake" => "0.8.7",
    "ruby-mp3info" => "0.7.1",
    "sources" => "0.0.1",
    "spoon" => "0.0.1",
    "tmail" => "1.2.7.1"
    }

#
# These are legacy static binaries we have that nobody seems to know where they came from of how to rebuild them
# so we are stuck with them for now
#
default[:encoders][:static_files] = { 
    "/usr/local/bin/lame" => "lame",
    "/usr/local/bin/aacPlusEnc" => "aacPlusEnc",
    "/usr/local/bin/aacPlusDec" => "aacPlusDec",
    "/usr/local/bin/ffmpeg" => "ffmpeg"
}


default[:encoders][:deploy_path] = "/data/apps/converter" 
default[:encoders][:github_url] = "git@github.com:iheartradio/converter"
default[:encoders][:deploy_key] = "/home/converter/.ssh/encoder-deploy"
default[:encoders][:wrapper_script] = "encoder-wrap-ssh.sh"
### JPD DEL default[:encoders][:converter_user] = "converter"
### JPD DEL default[:encoders][:nfsserver] = "10.5.40.2"
### JPD DEL default[:encoders][:ftp_mount] = "/data/encoder-ftp"

###
### IAD-ENC101 SPECIFIC - FOR ALLADIN
###

## WHATS THIS
default[:encoders][:encoder_mount] = "/data/encoder"
###

# Mounts specific to aladdin, webtools-east and iad-enc101
default[:aladdin][:nfs_server] = "10.5.32.164" # isilon
default[:aladdin][:aladdin_mount_dir] = "/data/aladdin"
default[:aladdin][:aladdin_export_dir] = "/ifs/webtools-east/aladdin"
###

# Mounts specefic to PRN (iad-enc104, iad-encmanager104)
default[:encoders][:prn_mount_dir] = "/data/prn"
default[:encoders][:prn_export_dir] = "/prn"

# default user mapping
default[:encoders][:user] = "converter"
default[:encoders][:ftpuser] = "ftp"
default[:encoders][:group] = "converter"

# various log dirs for management / logrotation
default[:encoders][:logdir] = "/data/logs/manager"
default[:encoders][:filemonitor][:logdir] = "/var/log/filemonitor"

# ingestion variables, specific to iad-encingestion101 and iad-encingestion102
default[:encoders][:filemonitor][:ingester_war] = "ingester.war"
default[:encoders][:filemonitor][:postgres_jar] = "postgresql-9.0-801.jdbc4.jar"
default[:encoders][:filemonitor][:ingestion_jar] = "http://files.ihrdev.com/ingestion/filemonitor-1.0.jar"
default[:encoders][:filemonitor][:static_files] = { 
    "/data/apps/filemonitor" => "filemonitor"
}

#### TALK SPECIFIC 
# talk links, specific to iad-enc103, iad-encmanager103
default[:encoders][:filemonitor][:talk_links] = { 
    "/PRN" => "/data/prn"
}

# talk startup scripts
default[:encoders][:talk][:manager][:startup_scripts] = {
     "/etc/init.d/talk_scanner" => "talk_scanner.erb",
     "/etc/init.d/talk_add_new" => "talk_add_new.erb",
     "/etc/init.d/talk_manager" => "talk_manager.erb"
    }

# number of converter procs to start:
default[:talk_converters][:num_processors] = "5"
default[:talk_scanner][:num_processors] = "2"

default[:encoders][:talk][:encoder][:startup_scripts] = {
    "/etc/init.d/talk_converter" => "talk_converter.erb"
    }

default[:encoders][:talk][:manager][:startup_scripts] = {
    "/etc/init.d/talk_scanner" => "talk_scanner.erb",
    "/etc/init.d/talk_add_new" => "talk_add_new.erb",
    "/etc/init.d/talk_manager" => "talk_manager.erb"
    }

# Checks for encoder (iad-enc103)
default[:encoders][:talk][:encoder][:monitor_scripts] = "talk_converter_check.erb"

# Checks for manager (iad-encmanager103)
default[:encoders][:talk][:manager][:monitor_scripts] = [
    "talk_scanner_check",
    "talk_add_new_check",
    "talk_manager_check"
]


####
#### MIXIN SPECIFIC
####
# mixins links, iad-enc105
default[:encoders][:filemonitor][:mixins_links] = { 
    "/Mixins" => "/data/encoder/tmp-ingestion/Mixins",
    "/Mixins_Watch_Folder" => "/data/encoder/tmp-ingestion/Mixins_Watch_Folder"
}

# ingestion links, need to be on all ingestion machines
default[:encoders][:filemonitor][:ingestion_links] = { 
    "/talk" => "/data/encoder/tmp-ingestion/talk/prod",
    "/Talk" => "/data/encoder/tmp-ingestion/Talk",
    "/Talk_Audio" => "/data/encoder/tmp-ingestion/Talk_Audio",
    "/Utility" => "/data/encoder/tmp-ingestion/Utility"
}

# mixins startups scripts
default[:encoders][:mixins][:manager][:startup_scripts] = {
    "/etc/init.d/mixin_converte" => "mixin_converter.erb",
    "/etc/init.d/mixin_manager" => "mixin_manager.erb"
}

# mixin crons
default[:encoders][:mixins][:manager][:crons] = [
    "/data/apps/converter/current/bin/cron/mixin_converter_check.sh",
    "/data/apps/converter/current/bin/cron/mixins_manager_check.sh"
]


#### IAD-ENCINGESTION SPECIFIC
default[:encoder][:filemonitor][:monitor_script] = "/data/apps/filemonitor/bin/fileMonitorService.sh"

# permanent isilon mounts
default[:encoders][:isilon_server] = "10.5.32.164"
default[:encoders][:p_ftp_export] = "/ifs/inbound-ftp"
default[:encoders][:p_ftp_mount] = "/data/inbound-ftp"
default[:encoders][:p_encoder_export] = "/ifs/encoder"
default[:encoders][:p_encoder_mount] = "/data/isi-encoder"
