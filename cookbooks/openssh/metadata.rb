maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs openssh"
version           "2.0.0"

recipe "openssh", "Installs openssh"

depends "iptables"

%w{ redhat centos fedora ubuntu debian arch scientific }.each do |os|
  supports os
end
