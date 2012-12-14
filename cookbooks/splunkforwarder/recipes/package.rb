#!/usr/bin/env ruby
# Downloads & installs splunkforwarder.
#
# Recipe:: package
# Cookbook Name:: splunkforwarder
# Source:: https://github.com/ampledata/cookbook-splunkforwarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


download_dir = '/usr/src'


# e.g. splunkforwarder-1.2.3-123456
package_prefix = [
  'splunkforwarder',
  node['splunkforwarder']['version'],
  node['splunkforwarder']['build']
].join('-')


package_suffix = value_for_platform(
  ['centos', 'redhat', 'suse', 'fedora'] => {
    'default' => if node['kernel']['machine'] == 'x86_64'
      '-linux-2.6-x86_64.rpm'
    else
      '.i386.rpm'
    end
  },
  ['debian', 'ubuntu'] => {
    'default' => if node['kernel']['machine'] == 'x86_64'
      '-linux-2.6-amd64.deb'
    else
      '-linux-2.6-intel.deb'
    end
  }
)


package_name = [package_prefix, package_suffix].join
package_download_path = File.join(download_dir, package_name)

# e.g http://downloads.splunk.com/5.0/u/l/s-1.2.3-12345.tar.gz
package_url = [
  node['splunkforwarder']['download_url'],
  node['splunkforwarder']['version'],
  'universalforwarder',
  'linux',
  package_name
].join('/')


directory download_dir


remote_file 'splunkforwarder: Download Package' do
  action :nothing
  backup false
  checksum node['splunkforwarder']['checksum']
  path package_download_path
  source package_url
end


http_request 'splunkforwarder: Check Package URL' do
  action :head
  if ::File.exists?(package_download_path)
    headers 'If-Modified-Since' => ::File.mtime(package_download_path).httpdate
  end
  message ''
  notifies(:create,
           resources(:remote_file => 'splunkforwarder: Download Package'),
           :immediately)
  url package_url
end


package package_name do
  case node['platform']
  when 'centos', 'redhat', 'fedora'
    provider Chef::Provider::Package::Rpm
  when 'debian', 'ubuntu'
    provider Chef::Provider::Package::Dpkg
  end

  source package_download_path
end
