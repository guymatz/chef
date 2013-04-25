name             'webplayer'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures webplayer'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ java application_python apache2 bondage users }.each do |dep|
  depends dep
end
