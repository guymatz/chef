i#!/bin/bash

COUNT=`find /data/backups -type f -ctime -5 -name "*_data.tar.gz"| wc -l`

if [ "$COUNT" -lt 1 ]; then
  echo "No fresh ING backups!!"
  exit 2
fi

echo "OK"
exit 0
