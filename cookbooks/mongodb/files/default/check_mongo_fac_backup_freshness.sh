#!/bin/bash

COUNT=`find /data/db/backups -type f -ctime -8 -name "*.tarz"| wc -l`

if [ "$COUNT" -lt 1 ]; then
  /usr/bin/nagios_passive.py iad-mongo-fac104 Mongo_FAC_Backup_Freshness 1 "FAC No Fresh Backups!"
else
  /usr/bin/nagios_passive.py iad-mongo-fac104 Mongo_FAC_Backup_Freshness 0 "OK"
fi
