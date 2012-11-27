#
# Cookbook Name:: bind-chroot
# Attributes:: default
# Copyright 2012, Gerald L. Hevener, Jr, M.S.
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

# Set CHROOT directory
default['bind_chroot']['chroot_dir'] = "/var/named/chroot"

# Set user name for BIND
default['bind_chroot']['bind_user_name'] = "named"

# Set group name for BIND
default['bind_chroot']['bind_group_name'] = "named"

# Store zones in OpenLDAP
default['bind_chroot']['store_zones_in_openldap'] = "no"

# Include zones.rfc1918
default['bind_chroot']['zones_rfc1928'] = "yes"

# Include openldap attributes file
include_attribute 'bind-chroot::openldap'
