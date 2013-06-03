#!/bin/bash

BACKUP_MASTER_DIR=/data/db/backups
BACKUP_FILE=`/bin/ls $BACKUP_MASTER_DIR/*.tarz | /bin/sort -r | /usr/bin/head -1`

if /bin/tar tzvf $BACKUP_FILE;
then
  /usr/bin/nagios_passive.py iad-mongo-fac104 Mongo_FAC_Backup_Corruption 0 "OK"
else
  /usr/bin/nagios_passive.py iad-mongo-fac104 Mongo_FAC_Backup_Corruption 1 "FAC backup may be corrupt"
fi
