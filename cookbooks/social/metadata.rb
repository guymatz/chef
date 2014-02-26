name             'facebook'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures facebook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{ users nagios tomcat7 java mongodb logrotate cron amp }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
