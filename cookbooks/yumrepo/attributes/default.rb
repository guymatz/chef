#
# Cookbook Name:: yum
# Attributes:: default
#
# Copyright 2011 Stefano Harding
#
# Licensed under the Apache License Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing software
# distributed under the License is distributed on an "AS IS" BASIS
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#centos version control variable -- set to whichever version you would like to mirror
default[:yum][:mirror][:centos_version]   = [ '6.3' ]
#desired symlinks
default[:yum][:mirror][:centos_links]            = { '6' => '6.3'
                                            }

default[:yum][:repos]                     = []
default[:yum][:packages]                  = %w[ redhat-lsb yum-utils ]
default[:yum][:fastestmirror]             = 'yum-fastestmirror'
default[:yum][:updatesd]                  = 'remove'
default[:yum][:failovermethod]            = 'priority'
default[:yum][:metadata_expire]           = '7d'

default[:yum][:repodir]                   = '/etc/yum/repos.d'
default[:yum][:conf]                      = '/etc/yum.conf'

default[:yum][:mirror][:package]          = 'createrepo'
default[:yum][:mirror][:basedir]          = '/data'
default[:yum][:mirror][:bindir]           = '/data/yum.bin'
default[:yum][:mirror][:yumdir]           = '/data/yum.repos'
default[:yum][:mirror][:cron_hour]        = 1
default[:yum][:mirror][:cron_minute]      = 30

default[:yum][:mirror][:centos_mirror]    = 'rsync://mirror.rackspace.com/centos/'

default[:yum][:mirror][:sync_centos]      = true
default[:yum][:mirror][:iso]              = false
default[:yum][:mirror][:arch]             = 'x86_64'

include_attribute 'yumrepo::centos'


# vi:filetype=ruby:tabstop=2:expandtab
