name             'amp'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures amp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ centos debian }.each do |os|
  supports os
end

%w{ users tomcat7 java mongodb nagios cron }.each do |dep|
  depends dep
end

%w{ rsyslog }.each do |sug|
  suggests sug
end
