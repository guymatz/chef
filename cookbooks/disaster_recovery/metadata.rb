name             'disaster_recovery'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures disaster_recovery'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ avamar users nagios nfs openssh cron postgresql}.each do |dep|
  depends dep
end

%w{ centos debian }.each do |os|
  supports os
end
