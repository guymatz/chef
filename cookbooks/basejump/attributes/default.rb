
default[:basejump][:db_name] = "basejump"
default[:basejump][:app_name] = "basejump"
default[:basejump][:db_user] = "basejump"
default[:basejump][:tools_user] = "basejumper"

default[:basejump][:repo] = "https://github.com/iheartradio/basejump.git"
#leaving this on HEAD while developing, eventually this will be a git-tag
default[:basejump][:rev] = "HEAD"

default[:basejump][:kickstarter][:tftp_root] = '/data/tftpboot'

case node['platform']
when "debian","ubuntu"
  default['basejump']['packages'] = %w[ python-mysqldb libmysqlclient-dev xinetd tftpd-hpa syslinux ]
when "redhat","centos","scientific","amazon"
  default['basejump']['packages'] = %w[ MySQL-python mysql-devel syslinux ]
end
