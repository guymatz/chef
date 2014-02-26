name             'quickio'
maintainer       'iHeartRadio'
maintainer_email 'astonecc@gmail.com'
license          'All rights reserved'
description      'Installs/Configures quickio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports		 'debian', '>= 7.0'

depends "iptables"
depends "cron"
