#
# Author:: Joshua Timberman <joshua@opscode.com>
# Copyright:: Copyright (c) 2009-2012, Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['resolver']['search'] = "ihr"
default['resolver']['server_role'] = 'nameserver'

case chef_environment
when /^hls|^staging-hls/
  default['resolver']['nameservers'] = ["10.5.57.10"]
  default['resolver']['options'] = Hash.new
when /^prod/
  default['resolver']['nameservers'] = ["10.5.32.21", "10.5.33.16"]
  default['resolver']['options'] = {
    "timeout" => 2,
    "rotate" => true
  }
when /^stage/
  default['resolver']['nameservers'] = ["10.5.32.21", "10.5.33.16"]
  default['resolver']['options'] = {
    "timeout" => 2,
    "rotate" => true
  }
  default['resolver']['fileserver_ip'] = '10.5.36.28'
  default['resolver']['fileserver_fqdn'] = 'files.ihrdev.com'
end
