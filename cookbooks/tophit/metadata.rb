name             'tophit'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures tophit'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ python }.each do |dep|
  depends dep
end
