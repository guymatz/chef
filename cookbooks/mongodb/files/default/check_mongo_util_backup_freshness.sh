#!/bin/bash

COUNT=`find /data/db/backups -type f -ctime -8 -name "*.tarz"| wc -l`

if [ "$COUNT" -lt 1 ]; then
  /usr/bin/nagios_passive.py iad-mongo-shared101 Mongo_UTIL_Backup_Freshness 1 "UTIL No Fresh Backups!"
else
  /usr/bin/nagios_passive.py iad-mongo-shared101 Mongo_UTIL_Backup_Freshness 0 "OK"
fi
