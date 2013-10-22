# This is the ProFTPD configuration file
#
# See: http://www.proftpd.org/docs/directives/linked/by-name.html

# Server Config - config used for anything outside a <VirtualHost> or <Global> context
# See: http://www.proftpd.org/docs/howto/Vhost.html

#ServerName                     "ProFTPD server"
#ServerIdent                    on "FTP Server ready."
ServerAdmin                     root@localhost
#DefaultServer                  on
Port                            0 #disable non-virtual FTP server
SocketBindTight                 on

# TraceLog /var/log/proftpd/trace.log
# Trace ssh2:20 sftp:10 scp:10

# Cause every FTP user except adm to be chrooted into their home directory
# Aliasing /etc/security/pam_env.conf into the chroot allows pam_env to
# work at session-end time (http://bugzilla.redhat.com/477120)
VRootEngine                     on
DefaultRoot                     ~ !adm
VRootAlias                      /etc/security/pam_env.conf etc/security/pam_env.conf

# Use pam to authenticate (default) and be authoritative
#AuthPAMConfig                  proftpd
#AuthOrder                      mod_auth_pam.c* mod_auth_unix.c
# If you use NIS/YP/LDAP you may need to disable PersistentPasswd
#PersistentPasswd               off

# Don't do reverse DNS lookups (hangs on DNS problems)
UseReverseDNS                   off

# Set the user and group that the server runs as
User                            nobody
Group                           nobody

# To prevent DoS attacks, set the maximum number of child processes
# to 20.  If you need to allow more than 20 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode; in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd)
MaxInstances                    200

# Disable sendfile by default since it breaks displaying the download speeds in
# ftptop and ftpwho
UseSendfile                     off

# Define the log formats
LogFormat                       default "%h %l %u %t \"%r\" %s %b"
LogFormat                       auth    "%v [%P] %h %t \"%r\" %s"

# Dynamic Shared Object (DSO) loading
# See README.DSO and howto/DSO.html for more details
#
# General database support (http://www.proftpd.org/docs/contrib/mod_sql.html)
   LoadModule mod_sql.c
#
# Support for base-64 or hex encoded MD5 and SHA1 passwords from SQL tables
# (contrib/mod_sql_passwd.html)
   LoadModule mod_sql_passwd.c
#
# Mysql support (requires proftpd-mysql package)
# (http://www.proftpd.org/docs/contrib/mod_sql.html)
   LoadModule mod_sql_mysql.c
#
# Postgresql support (requires proftpd-postgresql package)
# (http://www.proftpd.org/docs/contrib/mod_sql.html)
#   LoadModule mod_sql_postgres.c
#
# Quota support (http://www.proftpd.org/docs/contrib/mod_quotatab.html)
   LoadModule mod_quotatab.c
#
# File-specific "driver" for storing quota table information in files
# (http://www.proftpd.org/docs/contrib/mod_quotatab_file.html)
   LoadModule mod_quotatab_file.c
#
# SQL database "driver" for storing quota table information in SQL tables
# (http://www.proftpd.org/docs/contrib/mod_quotatab_sql.html)
   LoadModule mod_quotatab_sql.c
#
# LDAP support (requires proftpd-ldap package)
# (http://www.proftpd.org/docs/directives/linked/config_ref_mod_ldap.html)
#   LoadModule mod_ldap.c
#
# LDAP quota support (requires proftpd-ldap package)
# (http://www.proftpd.org/docs/contrib/mod_quotatab_ldap.html)
#   LoadModule mod_quotatab_ldap.c
#
# Support for authenticating users using the RADIUS protocol
# (http://www.proftpd.org/docs/contrib/mod_radius.html)
#   LoadModule mod_radius.c
#
# Retrieve quota limit table information from a RADIUS server
# (http://www.proftpd.org/docs/contrib/mod_quotatab_radius.html)
#   LoadModule mod_quotatab_radius.c
#
# Administrative control actions for the ftpdctl program
# (http://www.proftpd.org/docs/contrib/mod_ctrls_admin.html)
#   LoadModule mod_ctrls_admin.c
#
# Execute external programs or scripts at various points in the process
# of handling FTP commands
# (http://www.castaglia.org/proftpd/modules/mod_exec.html)
#   LoadModule mod_exec.c
#
# Support for POSIX ACLs
# (http://www.proftpd.org/docs/modules/mod_facl.html)
#   LoadModule mod_facl.c
#
# Support for using the GeoIP library to look up geographical information on
# the connecting client and using that to set access controls for the server
# (http://www.castaglia.org/proftpd/modules/mod_geoip.html)
#   LoadModule mod_geoip.c
#
# Configure server availability based on system load
# (http://www.proftpd.org/docs/contrib/mod_load.html)
#   LoadModule mod_load.c
#
# Limit downloads to a multiple of upload volume (see README.ratio)
#   LoadModule mod_ratio.c
#
# Rewrite FTP commands sent by clients on-the-fly,
# using regular expression matching and substitution
# (http://www.proftpd.org/docs/contrib/mod_rewrite.html)
#   LoadModule mod_rewrite.c
#
# Support for the SSH2, SFTP, and SCP protocols, for secure file transfer over
# an SSH2 connection (http://www.castaglia.org/proftpd/modules/mod_sftp.html)
LoadModule mod_sftp.c

# Allow handling of publickey authentication of users
# !! Note: In order to use OpenSSH public keys in a SFTPAuthorizedUserKeys,
# you must convert them to the RFC4716 format (see the Usage section).
# This is done using OpenSSH's ssh-keygen tool:
#
# ssh-keygen -e -f ~/.ssh/client_key.pub > ftp.client_key
SFTPAuthorizedUserKeys file:/etc/ssh/authorized_keys/%u
SFTPLog /var/log/proftpd/SFTP.log

#
# Use PAM to provide a 'keyboard-interactive' SSH2 authentication method for
# mod_sftp (http://www.castaglia.org/proftpd/modules/mod_sftp_pam.html)
#   LoadModule mod_sftp_pam.c
#
# Use SQL (via mod_sql) for looking up authorized SSH2 public keys for user
# and host based authentication
# (http://www.castaglia.org/proftpd/modules/mod_sftp_sql.html)
   LoadModule mod_sftp_sql.c
#
# Provide data transfer rate "shaping" across the entire server
# (http://www.castaglia.org/proftpd/modules/mod_shaper.html)
#   LoadModule mod_shaper.c
#
# Support for miscellaneous SITE commands such as SITE MKDIR, SITE SYMLINK,
# and SITE UTIME (http://www.proftpd.org/docs/contrib/mod_site_misc.html)
#   LoadModule mod_site_misc.c
#
# Provide an external SSL session cache using shared memory
# (contrib/mod_tls_shmcache.html)
#   LoadModule mod_tls_shmcache.c
#
# Use the /etc/hosts.allow and /etc/hosts.deny files, or other allow/deny
# files, for IP-based access control
# (http://www.proftpd.org/docs/contrib/mod_wrap.html)
#   LoadModule mod_wrap.c
#
# Use the /etc/hosts.allow and /etc/hosts.deny files, or other allow/deny
# files, as well as SQL-based access rules, for IP-based access control
# (http://www.proftpd.org/docs/contrib/mod_wrap2.html)
   LoadModule mod_wrap2.c
#
# Support module for mod_wrap2 that handles access rules stored in specially
# formatted files on disk
# (http://www.proftpd.org/docs/contrib/mod_wrap2_file.html)
#   LoadModule mod_wrap2_file.c
#
# Support module for mod_wrap2 that handles access rules stored in SQL
# database tables (http://www.proftpd.org/docs/contrib/mod_wrap2_sql.html)
   LoadModule mod_wrap2_sql.c
#
# Provide a flexible way of specifying that certain configuration directives
# only apply to certain sessions, based on credentials such as connection
# class, user, or group membership
# (http://www.proftpd.org/docs/contrib/mod_ifsession.html)
#   LoadModule mod_ifsession.c

## TLS (http://www.castaglia.org/proftpd/modules/mod_tls.html)
#<IfDefine TLS>
#  TLSEngine                    on
#  TLSRequired                  on
#  TLSRSACertificateFile                /etc/pki/tls/certs/proftpd.pem
#  TLSRSACertificateKeyFile     /etc/pki/tls/certs/proftpd.pem
#  TLSCipherSuite               ALL:!ADH:!DES
#  TLSOptions                   NoCertRequest
#  TLSVerifyClient              off
#  #TLSRenegotiate              ctrl 3600 data 512000 required off timeout 300
#  TLSLog                       /var/log/proftpd/tls.log
#  <IfModule mod_tls_shmcache.c>
#    TLSSessionCache            shm:/file=/var/run/proftpd/sesscache
#  </IfModule>
#</IfDefine>

# Dynamic ban lists (http://www.proftpd.org/docs/contrib/mod_ban.html)
# Enable this with PROFTPD_OPTIONS=-DDYNAMIC_BAN_LISTS in /etc/sysconfig/proftpd
<IfDefine DYNAMIC_BAN_LISTS>
  LoadModule                    mod_ban.c
  BanEngine                     on
  BanLog                        /var/log/proftpd/ban.log
  BanTable                      /var/run/proftpd/ban.tab

  # If the same client reaches the MaxLoginAttempts limit 2 times
  # within 10 minutes, automatically add a ban for that client that
  # will expire after one hour.
  BanOnEvent                    MaxLoginAttempts 2/00:10:00 01:00:00

  # Allow the FTP admin to manually add/remove bans
  BanControlsACLs               all allow user ftpadm
</IfDefine>

# Global Config - config common to Server Config and all virtual hosts
# See: http://www.proftpd.org/docs/howto/Vhost.html
<Global>

  DisplayConnect    /etc/ssh/ssh_banner

  # Umask 022 is a good standard umask to prevent new dirs and files
  # from being group and world writable
  Umask                         022

  # Allow users to overwrite files and change permissions
  AllowOverwrite                yes
  <Limit ALL SITE_CHMOD>
    AllowAll
  </Limit>

  # Local time set by puppet with 'include timezone::eastern'
  # per 3 rules: TimesGMT off, SetEnv TZ Eastern, no MDTM
  # See http://www.proftpd.org/docs/howto/Timestamps.html
  # Fails those FTP clients that use MDTM for retrieving the modification time
  # Statement: "ProFTPD supports MDTM for retrieving the modification time, in GMT. Period."
  TimesGMT off
  SetEnv TZ Eastern

#</Global> #extednd Global with MySQL below and disaable anonymous access
#
## A basic anonymous configuration, with an upload directory
## Enable this with PROFTPD_OPTIONS=-DANONYMOUS_FTP in /etc/sysconfig/proftpd
#<IfDefine ANONYMOUS_FTP>
#  <Anonymous ~ftp>
#    User                       ftp
#    Group                      ftp
#    AccessGrantMsg             "Anonymous login ok, restrictions apply."
#
#    # We want clients to be able to login with "anonymous" as well as "ftp"
#    UserAlias                  anonymous ftp
#
#    # Limit the maximum number of anonymous logins
#    MaxClients                 10 "Sorry, max %m users -- try again later"
#
#    # Put the user into /pub right after login
#    #DefaultChdir              /pub
#
#    # We want 'welcome.msg' displayed at login, '.message' displayed in
#    # each newly chdired directory and tell users to read README* files.
#    DisplayLogin               /welcome.msg
#    DisplayChdir               .message
#    DisplayReadme              README*
#
#    # Cosmetic option to make all files appear to be owned by user "ftp"
#    DirFakeUser                        on ftp
#    DirFakeGroup               on ftp
#
#    # Limit WRITE everywhere in the anonymous chroot
#    <Limit WRITE SITE_CHMOD>
#      DenyAll
#    </Limit>
#
#    # An upload directory that allows storing files but not retrieving
#    # or creating directories.
#    <Directory uploads/*>
#      AllowOverwrite           no
#      <Limit READ>
#        DenyAll
#      </Limit>
#
#      <Limit STOR>
#        AllowAll
#      </Limit>
#    </Directory>
#
#    # Don't write anonymous accesses to the system wtmp file (good idea!)
#    WtmpLog                    off
#
#    # Logging for the anonymous transfers
#    ExtendedLog                        /var/log/proftpd/access.log WRITE,READ default
#    ExtendedLog                        /var/log/proftpd/auth.log AUTH auth
#
#  </Anonymous>
#</IfDefine>
#

### Begin MySQL section ###
# per http://www.howtoforge.com/proftpd_mysql_virtual_hosting_p2
#

# The passwords in MySQL are encrypted using CRYPT
# And now MD5 - gm
SQLAuthTypes            MD5 Crypt
SQLAuthenticate         users* groups*
SQLPasswordEngine       on
SQLPasswordEncoding     hex

# used to connect to the database
# databasename@host database_user user_password
SQLConnectInfo  proftpd@10.73.232.102 proftpd proftpd101

# Here we tell ProFTPd the names of the database columns in the "usertable"
# we want it to interact with. Match the names with those in the db
SQLUserInfo     ftpuser userid passwd uid gid homedir shell

# Here we tell ProFTPd the names of the database columns in the "grouptable"
# we want it to interact with. Again the names match with those in the db
SQLGroupInfo    ftpgroup groupname gid members

# set min UID and GID - otherwise these are 999 each
SQLMinID        500

# create a user's home directory on demand if it doesn't exist
# SQLHomedirOnDemand on
# (we use CreateHome instead of deprecated SQLHomedirOnDemand)
CreateHome on

# Update count every time user logs in
#SQLLog PASS updatecount
#SQLNamedQuery updatecount UPDATE "count=count+1, accessed=now() WHERE userid='%u'" ftpuser

# Update modified everytime user uploads or deletes a file
#SQLLog  STOR,DELE modified
#SQLNamedQuery modified UPDATE "modified=now() WHERE userid='%u'" ftpuser

# User quotas
# ===========
QuotaEngine off
QuotaDirectoryTally off
QuotaDisplayUnits Mb
QuotaShowQuotas off

SQLNamedQuery get-quota-limit SELECT "name, quota_type, per_session, limit_type, bytes_in_avail, bytes_out_avail, bytes_xfer_avail, files_in_avail, files_out_avail, files_xfer_avail FROM ftpquotalimits WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery get-quota-tally SELECT "name, quota_type, bytes_in_used, bytes_out_used, bytes_xfer_used, files_in_used, files_out_used, files_xfer_used FROM ftpquotatallies WHERE name = '%{0}' AND quota_type = '%{1}'"

SQLNamedQuery update-quota-tally UPDATE "bytes_in_used = bytes_in_used + %{0}, bytes_out_used = bytes_out_used + %{1}, bytes_xfer_used = bytes_xfer_used + %{2}, files_in_used = files_in_used + %{3}, files_out_used = files_out_used + %{4}, files_xfer_used = files_xfer_used + %{5} WHERE name = '%{6}' AND quota_type = '%{7}'" ftpquotatallies

SQLNamedQuery insert-quota-tally INSERT "%{0}, %{1}, %{2}, %{3}, %{4}, %{5}, %{6}, %{7}" ftpquotatallies

QuotaLimitTable sql:/get-quota-limit
QuotaTallyTable sql:/get-quota-tally/update-quota-tally/insert-quota-tally

# Banner for FTP command LIST
# ===========================
SQLNamedQuery gettally  SELECT "ROUND((bytes_in_used/1048576),2) FROM ftpquotatallies WHERE name='%u'"
SQLNamedQuery getlimit  SELECT "ROUND((bytes_in_avail/1048576),2) FROM ftpquotalimits WHERE name='%u'"
SQLNamedQuery getfree   SELECT "ROUND(((ftpquotalimits.bytes_in_avail-ftpquotatallies.bytes_in_used)/1048576),2) FROM ftpquotalimits,ftpquotatallies WHERE ftpquotalimits.name = '%u' AND ftpquotatallies.name = '%u'"

SQLShowInfo   LIST    "226" "Used %{gettally}MB from %{getlimit}MB. You have %{getfree}MB available space."

### End MySQL section ###

DefaultRoot             ~ !adm
RootLogin               off
RequireValidShell       off

</Global>

### Begin virtual servers section ###

<VirtualHost 10.73.232.153>
  ServerName            "* FTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  Port                  21
  PassivePorts          60000 65535
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/ftp-auth.log AUTH auth
</VirtualHost>
<VirtualHost 10.73.232.153>
  ServerName            "* SFTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  SFTPEngine                    on
  Port                  2022
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/sftp-auth.log AUTH auth
  # per http://www.proftpd.org/docs/contrib/mod_sftp_sql.html
  SFTPHostKey /etc/ssh/sftp_host_dsa_key
  SFTPHostKey /etc/ssh/sftp_host_rsa_key
SFTPAuthorizedUserKeys file:/etc/ssh/authorized_keys/%u
DebugLevel 0
SFTPLog /var/log/proftpd/SFTP.log
      # Enable compression
      SFTPCompression delayed

      # Allow the same number of authentication attempts as OpenSSH.
      #
      # It is recommended that you explicitly configure MaxLoginAttempts
      # for your SSH2/SFTP instance to be higher than the normal
      # MaxLoginAttempts value for FTP, as there are more ways to authenticate
      # using SSH2.
      MaxLoginAttempts 6

  # These are for difficult clients. Tested, should work, came from the FAQ.  Tested as working by citi.

    # channelPacketSize 32KB channelWindowSize 4GB sftpProtocolVersion 1-6
    #
    # General fixes from the mod_sftp forum
    SFTPClientMatch ".*WS_FTP.*" channelWindowSize 1GB    #WS_FTP initial window size
    SFTPClientMatch ".*ClientSftp" sftpProtocolVersion 3  #CuteFTPPro8
    SFTPClientMatch ".*WinSCP.*" sftpProtocolVersion 3    #upload/download fix for WinSCP
    #
    # SecureBlackbox (SSH-2.0-SecureBlackbox.7)
    # http://www.eldos.com/sbb/download-release.php
    SFTPClientMatch ".*SecureBlackbox.*" sftpProtocolVersion 3
    #
    # GoAnywhere (SSH-2.0-1.0)
    # http://www.goanywheremft.com/products
    SFTPClientMatch "1.0" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # JaSFtp (SSH-2.0-J2SSH_Maverick_1.2.10_Sterling Commerce)
    # http://www.hiteksoftware.com/jasf/
    SFTPClientMatch ".*J2SSH_Maverick.*" channelWindowSize 1GB
    #
    # Robo-FTP (SSH-2.0-WeOnlyDo)
    # http://www.robo-ftp.com/
    SFTPClientMatch ".*WeOnlyDo.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # Network Automation (SSH-2.0-EldoS.SSHBlackbox.3)
    # http://www.networkautomation.com/
    SFTPClientMatch ".*EldoS.SSHBlackbox.3.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # /n Software BizTalk SFTP Receive (SSH-2.0-IP*Works! SSH Client v8.0)
    # http://www.nsoftware.com/products/biztalk/adapters/sftp.aspx
    SFTPClientMatch ".*IP.Works.*" channelWindowSize 1GB
    #
    # JSch - Java Secure Channel (SSH-2.0-JSCH-0.1.39)
    # http://www.jcraft.com/jsch/
    SFTPClientMatch "JSCH.*" channelWindowSize 1GB

    # Change the channelWindowSize to 1GB. Some SFTP clients, including ThinFile, can't
    # deal with a channelWindowSize >2GB, and will hang when logging in. For more, see
    # the QA on: http://www.castaglia.org/proftpd/modules/mod_sftp.html
    SFTPClientMatch .* channelWindowSize 1GB

</VirtualHost>

<VirtualHost 10.73.22.153>
  ServerName            "* FTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  Port                  21
  PassivePorts          60000 65535
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/ftp-auth.log AUTH auth
</VirtualHost>
<VirtualHost 10.73.22.153>
  ServerName            "* SFTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  SFTPEngine                    on
  Port                  2022
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/sftp-auth.log AUTH auth
  # per http://www.proftpd.org/docs/contrib/mod_sftp_sql.html
  SFTPHostKey /etc/ssh/sftp_host_dsa_key
  SFTPHostKey /etc/ssh/sftp_host_rsa_key
      # Enable compression
      SFTPCompression delayed

      # Allow the same number of authentication attempts as OpenSSH.
      #
      # It is recommended that you explicitly configure MaxLoginAttempts
      # for your SSH2/SFTP instance to be higher than the normal
      # MaxLoginAttempts value for FTP, as there are more ways to authenticate
      # using SSH2.
      MaxLoginAttempts 6

  # These are for difficult clients. Tested, should work, came from the FAQ.  Tested as working by citi.

    # channelPacketSize 32KB channelWindowSize 4GB sftpProtocolVersion 1-6
    #
    # General fixes from the mod_sftp forum
    SFTPClientMatch ".*WS_FTP.*" channelWindowSize 1GB    #WS_FTP initial window size
    SFTPClientMatch ".*ClientSftp" sftpProtocolVersion 3  #CuteFTPPro8
    SFTPClientMatch ".*WinSCP.*" sftpProtocolVersion 3    #upload/download fix for WinSCP
    #
    # SecureBlackbox (SSH-2.0-SecureBlackbox.7)
    # http://www.eldos.com/sbb/download-release.php
    SFTPClientMatch ".*SecureBlackbox.*" sftpProtocolVersion 3
    #
    # GoAnywhere (SSH-2.0-1.0)
    # http://www.goanywheremft.com/products
    SFTPClientMatch "1.0" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # JaSFtp (SSH-2.0-J2SSH_Maverick_1.2.10_Sterling Commerce)
    # http://www.hiteksoftware.com/jasf/
    SFTPClientMatch ".*J2SSH_Maverick.*" channelWindowSize 1GB
    #
    # Robo-FTP (SSH-2.0-WeOnlyDo)
    # http://www.robo-ftp.com/
    SFTPClientMatch ".*WeOnlyDo.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # Network Automation (SSH-2.0-EldoS.SSHBlackbox.3)
    # http://www.networkautomation.com/
    SFTPClientMatch ".*EldoS.SSHBlackbox.3.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # /n Software BizTalk SFTP Receive (SSH-2.0-IP*Works! SSH Client v8.0)
    # http://www.nsoftware.com/products/biztalk/adapters/sftp.aspx
    SFTPClientMatch ".*IP.Works.*" channelWindowSize 1GB
    #
    # JSch - Java Secure Channel (SSH-2.0-JSCH-0.1.39)
    # http://www.jcraft.com/jsch/
    SFTPClientMatch "JSCH.*" channelWindowSize 1GB

    # Change the channelWindowSize to 1GB. Some SFTP clients, including ThinFile, can't
    # deal with a channelWindowSize >2GB, and will hang when logging in. For more, see
    # the QA on: http://www.castaglia.org/proftpd/modules/mod_sftp.html
    SFTPClientMatch .* channelWindowSize 1GB

</VirtualHost>

<VirtualHost 10.73.32.153>
  ServerName            "* FTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  Port                  21
  PassivePorts          60000 65535
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/ftp-auth.log AUTH auth
</VirtualHost>
<VirtualHost 10.73.32.153>
  ServerName            "* SFTP *"
  ServerIdent                   off # MarkitSERV Access Control Policy 5.3
  SFTPEngine                    on
  Port                  2022
  WtmpLog                       off
  ExtendedLog                   /var/log/proftpd/sftp-auth.log AUTH auth
  # per http://www.proftpd.org/docs/contrib/mod_sftp_sql.html
  SFTPHostKey /etc/ssh/sftp_host_dsa_key
  SFTPHostKey /etc/ssh/sftp_host_rsa_key
  SFTPAuthorizedUserKeys file:/etc/ssh/authorized_keys/%u
SFTPLog /var/log/proftpd/SFTP.log
      # Enable compression
      SFTPCompression delayed

      # Allow the same number of authentication attempts as OpenSSH.
      #
      # It is recommended that you explicitly configure MaxLoginAttempts
      # for your SSH2/SFTP instance to be higher than the normal
      # MaxLoginAttempts value for FTP, as there are more ways to authenticate
      # using SSH2.
      MaxLoginAttempts 6

  # These are for difficult clients. Tested, should work, came from the FAQ.  Tested as working by citi.

    # channelPacketSize 32KB channelWindowSize 4GB sftpProtocolVersion 1-6
    #
    # General fixes from the mod_sftp forum
    SFTPClientMatch ".*WS_FTP.*" channelWindowSize 1GB    #WS_FTP initial window size
    SFTPClientMatch ".*ClientSftp" sftpProtocolVersion 3  #CuteFTPPro8
    SFTPClientMatch ".*WinSCP.*" sftpProtocolVersion 3    #upload/download fix for WinSCP
    #
    # SecureBlackbox (SSH-2.0-SecureBlackbox.7)
    # http://www.eldos.com/sbb/download-release.php
    SFTPClientMatch ".*SecureBlackbox.*" sftpProtocolVersion 3
    #
    # GoAnywhere (SSH-2.0-1.0)
    # http://www.goanywheremft.com/products
    SFTPClientMatch "1.0" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # JaSFtp (SSH-2.0-J2SSH_Maverick_1.2.10_Sterling Commerce)
    # http://www.hiteksoftware.com/jasf/
    SFTPClientMatch ".*J2SSH_Maverick.*" channelWindowSize 1GB
    #
    # Robo-FTP (SSH-2.0-WeOnlyDo)
    # http://www.robo-ftp.com/
    SFTPClientMatch ".*WeOnlyDo.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # Network Automation (SSH-2.0-EldoS.SSHBlackbox.3)
    # http://www.networkautomation.com/
    SFTPClientMatch ".*EldoS.SSHBlackbox.3.*" sftpProtocolVersion 3 channelWindowSize 1GB
    #
    # /n Software BizTalk SFTP Receive (SSH-2.0-IP*Works! SSH Client v8.0)
    # http://www.nsoftware.com/products/biztalk/adapters/sftp.aspx
    SFTPClientMatch ".*IP.Works.*" channelWindowSize 1GB
    #
    # JSch - Java Secure Channel (SSH-2.0-JSCH-0.1.39)
    # http://www.jcraft.com/jsch/
    SFTPClientMatch "JSCH.*" channelWindowSize 1GB

    # Change the channelWindowSize to 1GB. Some SFTP clients, including ThinFile, can't
    # deal with a channelWindowSize >2GB, and will hang when logging in. For more, see
    # the QA on: http://www.castaglia.org/proftpd/modules/mod_sftp.html
    SFTPClientMatch .* channelWindowSize 1GB

</VirtualHost>
### End virtual servers section ###
