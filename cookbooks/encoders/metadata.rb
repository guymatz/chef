name             'encoders'
maintainer       'ccd ihr ops'
maintainer_email 'ccd-sa@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures encoder'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'


%w{ apache2 yum java line application_ruby tomcat7 logrotate nagios sudo }.each do |dep|
    depends dep
end
