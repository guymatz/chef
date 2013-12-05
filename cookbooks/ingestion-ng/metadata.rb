name             'ingestion-ng'
maintainer       'ccd ihr ops'
maintainer_email 'ccd-sa@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures encoder'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'


%w{ java yum logrotate nagios sudo }.each do |dep|
    depends dep
end
