name             'radioedit'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures radioedit'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.0'

%w{ python application_python sudo logrotate nodejs supervisor }.each do |d|
  depends d
end
