version '1.0.0'

description 'Installs & Configures Splunk Forwarder'

maintainer 'Greg Albrecht'
maintainer_email 'gba@splunk.com'
license 'Apache License 2.0'


%w{redhat centos fedora debian suse ubuntu}.each do |os|
  supports os
end


long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
