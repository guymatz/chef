#
# Cookbook Name:: jenkins
# Attributes:: default
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Seth Chisamore <schisamo@opscode.com>
#
# Copyright 2010, VMware, Inc.
# Copyright 2012, Opscode, Inc.
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

default['jenkins']['mirror'] = "http://mirrors.jenkins-ci.org"
default['jenkins']['java_home'] = ENV['JAVA_HOME']
default['jenkins']['iptables_allow'] = "disable"

case node[:platform_family]
when "debian"
  default['jenkins']['packages'] = %w{
    maven
    libglib2.0-dev
    libssl-dev
    check
    libevent-dev
    libmemcached-dev
    libjson0-dev
    sshpass
  }
when "rhel"
  default['jenkins']['packages'] = %w{ sshpass ruby-devel make gcc libxml2 libxslt-devel libxml2-devel }
end

default['jenkins']['recipes'] = %w{ rvm::ruby_192 }
