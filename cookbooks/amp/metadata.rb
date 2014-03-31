# ##############################################################
# @Changelog
#   - 3/17/14 GP
#      - Bumped the version to 1.0.2 for the changes in ./templates/default/amp-extended-log-chk.sh.erb
#   - 3/25/14 GM
#      - reverting to known, good release of amp, 2.22-vanilla-ice
#
# ##############################################################
name             'amp'
maintainer       'iHeartRadio'
maintainer_email 'none@none.com'
license          'All rights reserved'
description      'Installs/Configures amp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.3'


%w{ centos debian }.each do |os|
  supports os
end

%w{ users tomcat7 java mongodb nagios cron hostsfile }.each do |dep|
  depends dep
end

%w{ rsyslog }.each do |sug|
  suggests sug
end
