name             'authorization'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures authorization'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'heartbeat'
depends 'openssl'
depends "postgresql"
depends "sysctl"
depends "cron"
depends "multipath"
depends "bonded_interfaces"
depends 'php'
