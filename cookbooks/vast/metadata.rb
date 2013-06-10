name             'vast'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures vast'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ tomcat7 nagios cron }.each do |dep|
  depends dep
end
