#!/bin/bash

BACKUP_DIR=/data/backups/authdb1a-ha
DATA_BACKUP=`/bin/ls $BACKUP_DIR/*data.tar.gz | sort -r | head -1`
FILESIZE=$(/usr/bin/du -b "$DATA_BACKUP" | /bin/cut -f 1)

if /sbin/ip addr | grep -v '10.5.43.23';
then
 if [ "$FILESIZE" -gt "1342177280" ]; 
 then 
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Size 0 "OK"
 else
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Size 1 "INGDB data backup file is too small!"
 fi
fi
