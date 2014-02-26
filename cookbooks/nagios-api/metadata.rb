name             'nagios-api'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures nagios-api'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ application supervisor ssh-wrapper }.each do |dep|
  depends dep
end
