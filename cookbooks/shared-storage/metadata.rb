name             'shared-storage'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures shared-storage'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ users nagios nfs files.ihrdev.com }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
