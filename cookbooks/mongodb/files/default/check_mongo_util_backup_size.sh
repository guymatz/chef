#!/bin/bash

BACKUP_DIR=/data/db/backups
DATA_BACKUP=`/bin/ls $BACKUP_DIR/*.tarz | sort -r | head -1`
FILESIZE=$(/usr/bin/du -b "$DATA_BACKUP" | /bin/cut -f 1)

if [ "$FILESIZE" -gt "2000000000" ]; 
then 
  /usr/bin/nagios_passive.py iad-mongo-shared102 Mongo_UTIL_Backup_Size 0 "OK"
else
  /usr/bin/nagios_passive.py iad-mongo-shared102 Mongo_UTIL_Backup_Size 1 "UTIL backup file is too small!"
fi
