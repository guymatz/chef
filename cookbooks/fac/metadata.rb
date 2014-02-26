name             'fac'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures fac'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ java cron hostsfile attivio nagios elasticsearch amp }.each do |dep|
  depends dep
end
