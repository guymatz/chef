#!/bin/bash

BACKUP_DIR=/data/backups/`hostname -s`
DATA_BACKUP=`/bin/ls $BACKUP_DIR/*data.tar.gz | sort -r | head -1`
FILESIZE=$(/usr/bin/du -b "$DATA_BACKUP" | /bin/cut -f 1)

if /sbin/ip addr | grep -q '10.5.43.23';
then
 if [ "$FILESIZE" -gt "1342177280" ]; 
 then 
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Size 0 "OK"
 else
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Size 1 "AuthDB data backup file is too small!"
 fi
fi
