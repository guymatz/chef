maintainer       "Kos Media, LLC"
maintainer_email "jeremy@dailykos.com"
license          "MIT"
description      "Installs/Configures zeus-zxtm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
recipe		 "default", "Main Zeus ZXTM configuration"

attribute "zeus",
  :display_name => "Zeus Hash",
  :description => "Location for Zeus configuration",
  :type => "hash"

attribute "zeus/zeus_root",
  :display_name => "Zeus Root",
  :description => "Root of Zeus install",
  :default => "/usr/local/zeus"

attribute "zeus/tarball_url",
  :display_name => "Zeus Tarball URL",
  :description => "Location of Zeus installation tarball",
  :default => "http://example.com/zeus/Linux-x86_64.tgz"

attribute "zeus/tarball_dir",
  :display_name => "Zeus Tarball Directory",
  :description => "Directory the Zeus install tarball untars into. Varies between versions.",
  :default => "ZeusTM_90r3_Linux-x86_64"

attribute "zeus/checksum",
  :display_name => "Zeus Checksum",
  :description => "Checksum of the Zeus installation tarball",
  :default => "94e65172855d85ceb37104535058ef9c3f658282"

attribute "zeus/user",
  :display_name => "Zeus User",
  :description => "User Zeus runs as",
  :default => "nobody"

attribute "zeus/group",
  :display_name => "Zeus Group",
  :description => "Group Zeus runs as",
  :default => "nogroup"
