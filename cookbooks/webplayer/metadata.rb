name             'webplayer'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures webplayer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ java application_python apache2 bondage users logrotate cron membase }.each do |dep|
  depends dep
end
