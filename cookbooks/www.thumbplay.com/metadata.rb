name             'www.thumbplay.com'
maintainer       'iHeartRadio'
maintainer_email 'jderagon@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures www.thumbplay.com'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w{ apache2 users }.each do |dep|
  depends dep
end
