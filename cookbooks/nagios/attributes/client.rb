#
# Author:: Joshua Sierles <joshua@37signals.com>
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Nathan Haneysmith <nathan@opscode.com>
# Author:: Seth Chisamore <schisamo@opscode.com>
# Cookbook Name:: nagios
# Attributes:: client
#
# Copyright 2009, 37signals
# Copyright 2009-2011, Opscode, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform']
when "ubuntu","debian"
  default['nagios']['client']['install_method'] = 'package'
  default['nagios']['nrpe']['pidfile'] = '/var/run/nagios/nrpe.pid'
when "redhat","centos","fedora","scientific","amazon"
  default['nagios']['client']['install_method'] = 'source'
  default['nagios']['nrpe']['pidfile'] = '/var/run/nrpe.pid'
else
  default['nagios']['client']['install_method'] = 'source'
  default['nagios']['nrpe']['pidfile'] = '/var/run/nrpe.pid'
end

default['nagios']['nrpe']['home']              = "/usr/lib/nagios"
default['nagios']['nrpe']['conf_dir']          = "/etc/nagios"
default['nagios']['nrpe']['dont_blame_nrpe']   = "0"
default['nagios']['nrpe']['command_timeout']   = "60"

# for plugin from source installation
default['nagios']['plugins']['version']  = '1.4.15'
default['nagios']['plugins']['checksum'] = '51136e5210e3664e1351550de3aff4a766d9d9fea9a24d09e37b3428ef96fa5b'

# for nrpe from source installation
default['nagios']['nsca']['version']  = '2.7.2'
default['nagios']['nsca']['checksum'] = 'fb41e3b536735235056643fb12187355c6561b9148996c093e8faddd4fced571'
default['nagios']['nrpe']['version']  = '2.12'
default['nagios']['nrpe']['checksum'] = '7e8d093abef7d7ffc7219ad334823bdb612121df40de2dbaec9c6d0adeb04cfc'
default['nagios']['nrpe']['mon_host_ips'] = [ '10.5.36.11',
                                              '10.5.40.12',
                                              '10.5.43.20',
                                              '10.5.32.21',
                                              '10.5.52.6',
                                              '10.5.54.8',
                                              '10.5.53.12',
                                              '10.5.53.145',
                                              '10.5.52.28',
                                              '10.5.54.21',
                                              '10.5.57.11',
                                              '10.5.58.28'
                                            ]

# for nsca from source installation
case chef_environment
when /^hls/
  default['nagios']['nsca']['url']    = 'http://prdownloads.sourceforge.net/sourceforge/nagios' 
  default['nagios']['nrpe']['url']    = 'http://prdownloads.sourceforge.net/sourceforge/nagios'
  default['nagios']['plugins']['url'] = 'https://www.nagios-plugins.org/download'
when /^staging-hls/
  default['nagios']['nsca']['url']    = 'http://prdownloads.sourceforge.net/sourceforge/nagios' 
  default['nagios']['nrpe']['url']    = 'http://prdownloads.sourceforge.net/sourceforge/nagios'
  default['nagios']['plugins']['url'] = 'https://www.nagios-plugins.org/download'
when /^prod/
  default['nagios']['nsca']['url']      = 'http://yum.ihr/files'
  default['nagios']['nrpe']['url']      = 'http://yum.ihr/files'
  default['nagios']['plugins']['url']   = 'http://yum.ihr/files'
when /^stage/
  default['nagios']['nsca']['url']      = 'http://yum.ihr/files'
  default['nagios']['nrpe']['url']      = 'http://yum.ihr/files'
  default['nagios']['plugins']['url']   = 'http://yum.ihr/files'
end


default['nagios']['checks']['memory']['critical'] = 150
default['nagios']['checks']['memory']['warning']  = 250
default['nagios']['checks']['load']['critical']   = "30,20,10"
default['nagios']['checks']['load']['warning']    = "15,10,5"
default['nagios']['checks']['smtp_host'] = String.new

default['nagios']['server_role'] = "monitoring"
default['nagios']['multi_environment_monitoring'] = false
