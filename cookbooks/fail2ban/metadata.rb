name              "fail2ban"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures fail2ban"
version           "2.0.0"

recipe "fail2ban", "Installs and configures fail2ban"

depends "yum"
depends "logrotate"

%w{ debian ubuntu redhat centos fedora scientific amazon oracle}.each do |os|
  supports os
end
