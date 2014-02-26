name             'avamar'
maintainer       'iHeart'
maintainer_email 'gregorypatmore@clearchannel.com'
license          'All rights reserved'
description      'Installs/Configures avamar client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

#only have an install rpm for RHEL and Centos 
%w{ redhat centos }.each do |os|
  supports os
end

# host file entry required
%w{ hostsfile }.each do |dep|
  depends dep
end

