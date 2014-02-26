name             'bastion'
maintainer       'iHeartRadio'
maintainer_email 'none@none@gmail.com'
license          'All rights reserved'
description      'Installs/Configures bastion'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'



%w{ users sudo nagios rsyslog openssh iptables ntp chef-client operations timezone zsh }.each do |dep|
  depends dep
end

%w{ debian centos }.each do |os|
  supports os
end
