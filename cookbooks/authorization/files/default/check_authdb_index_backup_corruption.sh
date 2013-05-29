#!/bin/bash

BACKUP_MASTER_DIR=/data/backups/`hostname -s`
BACKUP_FILE=`/bin/ls $BACKUP_MASTER_DIR/*index.tar.gz | /bin/sort -r | /usr/bin/head -1`

if /sbin/ip addr | grep -q '10.5.43.23';
then
 if /bin/tar tzvf $BACKUP_FILE;
 then
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Index_Backup_Corruption 0 "OK"
 else
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Index_Backup_Corruption 1 "AuthDB index backup may be corrupt"
 fi
fi
