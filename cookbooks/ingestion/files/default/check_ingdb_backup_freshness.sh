#!/bin/bash

COUNT=`find /data/backups/iad-ing101 -type f -ctime -5 -name "*_data.tar.gz"| wc -l`

if [ "$COUNT" -lt 1 ]; then
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Backup_Freshness 1 "IngDB No Fresh Backups!"
else
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Backup_Freshness 0 "OK"
fi
