maintainer        "CCD-SA@CLEARCHANNEL.COM"
maintainer_email  "ccd-sa@clearchannel.com"
license           "Apache 2.0"
description       "coopbook specific to https://jira.ccrd.clearchannel.com/browse/OPS-5657"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "2.0.0"

%w{ ubuntu debian redhat centos fedora suse freebsd openbsd mac_os_x mac_os_x_server windows }.each do |os|
  supports os
end
