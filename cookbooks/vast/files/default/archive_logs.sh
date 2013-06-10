#!/bin/bash
FILES=$(find /data/apps/tomcat7/logs -name 'localhost_access_log*' -mtime +1)
cd /data/apps/tomcat7/logs
tar czpf localhost.access.log.archive.$(date +%Y%m%d).tar.gz $FILES
rm -f $FILES
find /data/apps/tomcat7/logs -name 'localhost.access.log.archive*' -mtime +10 -exec rm {} \;
