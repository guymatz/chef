name             'mongodb'
maintainer       'iHeartRadio'
maintainer_email 'josephhammerman@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures mongodb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ users }.each do |dep|
  depends dep
end

%{ centos }.each do |os|
  supports os
end

depends "lvm"
