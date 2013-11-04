#!/bin/bash

BACKUP_DIR=/data/backups/iad-stg-ing101
DATA_BACKUP=`/bin/ls $BACKUP_DIR/*data.tar.gz | sort -r | head -1`
FILESIZE=$(/usr/bin/du -b "$DATA_BACKUP" | /bin/cut -f 1)

if [ "$FILESIZE" -gt "1342177280" ]; 
then 
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Backup_Size 0 "OK"
else
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Backup_Size 1 "INGDB data backup file is too small!"
fi
