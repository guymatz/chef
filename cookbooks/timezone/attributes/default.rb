# Timezone for iHeart Hosts
#
# Just so you know, anything not UTC is a bad idea to begin with
#
# The RFC states it best
#
#    RFC3339
#
#      4.1. Coordinated Universal Time (UTC)
#
#    Because the daylight saving rules for local time zones are so
#    convoluted and can change based on local law at unpredictable times,
#    true interoperability is best achieved by using Coordinated Universal
#    Time (UTC).  This specification does not cater to local time zone
#    rules.


default['timezone']['zone'] = "UTC"
default['timezone']['zonefile'] = "/usr/share/zoneinfo/UTC"
