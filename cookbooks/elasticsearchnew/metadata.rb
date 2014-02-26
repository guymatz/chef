name             'elasticsearch-new'
maintainer       'iHeartRadio'
maintainer_email 'jake.plimack@gmail.com'
license          'All rights reserved'
description      'Installs/Configures elasticsearch-new'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ users nagios cron }.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
