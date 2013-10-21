name             'ingestion'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures ingestion'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "postgresql"
depends "sysctl"
depends "cron"
depends "multipath"
depends "bonded_interfaces"
depends 'php'
