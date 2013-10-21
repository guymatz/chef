name             'ops.ihrdev.com'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures ops.ihrdev.com'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ apache2 users }.each do |dep|
  depends dep
end
