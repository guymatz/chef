#!/bin/bash

COUNT=`find /data/db/backups -type f -ctime -2 -name "*.tarz"| wc -l`

if [ "$COUNT" -lt 1 ]; then
  /usr/bin/nagios_passive.py iad-mongo-restore101 Mongo_USR_Backup_Freshness 1 "USR No Fresh Backups!"
else
  /usr/bin/nagios_passive.py iad-mongo-restore101 Mongo_USR_Backup_Freshness 0 "OK"
fi
