name             'facebook'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures facebook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ users nagios tomcat7 java mongodb logrotate }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
