name             'partners'
maintainer       'iHeartRadio'
maintainer_email 'ccd-sa@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures partners'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'application_python'
depends 'users'
depends 'logrotate'
depends 'cron'
