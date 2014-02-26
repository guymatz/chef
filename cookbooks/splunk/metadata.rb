maintainer       "BBY Solutions, Inc."
maintainer_email "andrew.painter@bestbuy.com"
license          "Apache 2.0"
description      "Installs/Configures a Splunk Server, Forwarders, and Apps"
version          "1.0.0"

depends "logrotate"
#GP edit 7/29/13 - added to create the splunk user/group used by forwarder
depends "users"


%w{redhat centos fedora debian ubuntu}.each do |os|
  supports os
end
