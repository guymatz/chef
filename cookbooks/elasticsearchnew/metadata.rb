name             'elasticsearch-new'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures elasticsearch-new'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

%w{ users nagios }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
