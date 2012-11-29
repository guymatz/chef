#
# Cookbook Name:: bind-chroot
# Attributes:: openldap 
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

# Set attributes for OpenLDAP

# Attributes currently used by this cookbook
default['bind-chroot']['ldap']['database'] = 'sdb'
default['bind-chroot']['ldap']['suffix'] = '"dc=example,dc=com"'

# Default rootdn password is tuxrocks!
default['bind-chroot']['ldap']['rootdn'] = 'dc=example,dc=com'

default['bind-chroot']['ldap']['rootpw'] = '{SSHA}tneSgm2xv5nHvEAPkCfPwk7FCpMVYvJg'

# Set this to ldap::suffix without the 'dc=' parts
default['bind-chroot']['ldap']['directory'] = '/var/lib/ldap/example.com'

###################################################################

default['bind-chroot']['ldap']['dn'] = ''
default['bind-chroot']['ldap']['objectClass'] = ''
default['bind-chroot']['ldap']['relativeDomainName'] = ''
default['bind-chroot']['ldap']['zoneName'] = ''
default['bind-chroot']['ldap']['dNSTTL'] = ''
default['bind-chroot']['ldap']['dNSClass'] = ''
default['bind-chroot']['ldap']['sOARecord'] = ''
default['bind-chroot']['ldap']['nSRecord'] = ''
default['bind-chroot']['ldap']['mXRecord'] = ''
default['bind-chroot']['ldap']['cNAMERecord'] = ''
default['bind-chroot']['ldap']['aRecord'] = ''
default['bind-chroot']['ldap']['pTRRecord'] = ''
default['bind-chroot']['ldap']['hInfoRecord'] = ''
default['bind-chroot']['ldap']['mInfoRecord'] = ''
default['bind-chroot']['ldap']['tXTRecord'] = ''
default['bind-chroot']['ldap']['aFSDBRecord'] = ''
default['bind-chroot']['ldap']['SigRecord'] = ''
default['bind-chroot']['ldap']['KeyRecord'] = ''
default['bind-chroot']['ldap']['aAAARecord'] = ''
default['bind-chroot']['ldap']['LocRecord'] = ''
default['bind-chroot']['ldap']['nXTRecord'] = ''
default['bind-chroot']['ldap']['sRVRecord'] = ''
default['bind-chroot']['ldap']['nAPTRRecord'] = ''
default['bind-chroot']['ldap']['kXRecord'] = ''
default['bind-chroot']['ldap']['certRecord'] = ''
default['bind-chroot']['ldap']['a6Record'] = ''
default['bind-chroot']['ldap']['dNameRecord'] = ''
default['bind-chroot']['ldap']['dSRecord'] = ''
default['bind-chroot']['ldap']['sSHFPRecord'] = ''
default['bind-chroot']['ldap']['rRSIGRecord'] = ''
default['bind-chroot']['ldap']['nSECRecord'] = ''
