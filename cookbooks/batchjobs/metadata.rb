name             'batchjobs'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures batchjobs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

%w{ python amp }.each do |dep|
  depends dep
end

depends "python"
