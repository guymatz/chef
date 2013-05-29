#!/bin/bash

SHORTNAME=`hostname -s`
COUNT=`find /data/backups/$SHORTNAME -type f -ctime -5 -name "*_data.tar.gz"| wc -l`

if /sbin/ip addr | grep -q '10.5.43.23';
then 
  if [ "$COUNT" -lt 1 ]; 
  then
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Freshness 1 "AUTHDB No Fresh Backups!"
 else
   /usr/bin/nagios_passive.py iad-auth101-v260.ihr AUTHDB_Backup_Freshness 0 "OK"
 fi
fi
