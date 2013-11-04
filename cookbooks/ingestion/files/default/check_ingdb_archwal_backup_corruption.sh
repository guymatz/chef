#!/bin/bash

BACKUP_MASTER_DIR=/data/backups/iad-stg-ing101
BACKUP_FILE=`/bin/ls $BACKUP_MASTER_DIR/*archwal.tar.gz | /bin/sort -r | /usr/bin/head -1`

if /bin/tar tzvf $BACKUP_FILE;
then
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Archwal_Backup_Corruption 0 "OK"
else
  /usr/bin/nagios_passive.py iad-ing101 INGDB_Archwal_Backup_Corruption 1 "IngDB archwal backup may be corrupt"
fi
