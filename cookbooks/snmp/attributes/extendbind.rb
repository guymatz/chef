#
# Cookbook Name:: snmp
# Attributes:: extendbind
#
# Copyright 2012, Eric G. Wolfe
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

case node['platform_family']
when "redhat"
  case node['platform_version'].to_i
  when 5
    # BIND <= 9.3 stats
    default['snmp']['rndc_stats_script'] = "snmp_rndc_stats.pl"
  when 6
    # BIND >= 9.7 stats
    default['snmp']['rndc_stats_script'] = "snmp_rndc_stats_v97.pl"
  end
else
  # Else assume we're using BIND 9.7 or newer
  default['snmp']['rndc_stats_script'] = "snmp_rndc_stats_v97.pl"
end
