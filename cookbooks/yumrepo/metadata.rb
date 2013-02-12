maintainer       "Stefano Harding -- modifications by Mark Rechler"
maintainer_email "mrechler@iheart.com"
license          "Apache 2.0"
description      "Installs/Configures yumrepo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.2.3"
depends          "apache2"
depends          "rsync"
depends          "cron"
recipe           "yumrepo::server", "Sets up and optionally synchronizes remote Yum repositories."
recipe           "yumrepo::mirror", "Sets up mirrors for centos."
%w{ centos }.each { |os| supports os }
%w{ hostsfile }.each { |cb| depends cb }

attribute 'yumrepo/package',
  :display_name => 'Package',
  :description  => 'Name of package to install',
  :default      => 'createrepo'

attribute 'yumrepo/basedir',
  :display_name => 'Base directory',
  :description  => 'Location of /sysadm mount point',
  :default      => '/sysadm'

attribute 'yumrepo/bindir',
  :display_name => 'Binary files',
  :description  => 'Location of binary files',
  :default      => '/sysadm/bin'

attribute 'yumrepo/yumdir',
  :display_name => 'Base Directory',
  :description  => 'Location where to sync repos to',
  :default      => '/sysadm/yum.repos'

attribute 'yumrepo/cron_hour',
  :display_name => 'Crontab Hour',
  :description  => 'At what hour to run the yum-repo-sync.rb cron',
  :default      => '1'

attribute 'yumrepo/cron_minute',
  :display_name => 'Crontab Minute',
  :description  => 'At what minute to run the yum-repo-sync.rb cron',
  :default      => '30'

attribute 'yumrepo/centos_mirror',
  :display_name => 'CentOS Mirror',
  :description  => 'Location of where to sync the repo from',
  :default      => 'rsync://mirror.rackspace.com/centos/'

attribute 'yumrepo/sync_centos',
  :display_name => 'Sync CentOS',
  :description  => 'Whether to sync the repo',
  :default      => 'true'

attribute 'yumrepo/arch',
  :display_name => 'Architecture',
  :description  => 'What architectures to sync',
  :default      => 'x86_64'

attribute 'yumrepo/centos_version',
  :display_name => 'CentOS Version',
  :description  => 'Which CentOS versions to sync (this is an array)',
  :default      => '6.3'

attribute 'yumrepo/centos_links',
  :display_name => 'CentOS Symlinks',
  :description  => 'What CentOS symlinks to setup (this is a hash)',
  :default      => '{ 6 => 6.3 }'

