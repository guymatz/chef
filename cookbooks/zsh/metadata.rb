maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs zsh"
version           "2.0.0"

recipe "zsh", "Installs zsh"

%w{ubuntu debian centos redhat amazon scientific fedora}.each do |os|
  supports os
end
