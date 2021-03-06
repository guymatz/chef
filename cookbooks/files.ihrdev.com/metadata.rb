name             'files.ihrdev.com'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures files.ihrdev.com'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'


%w{ nfs }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
