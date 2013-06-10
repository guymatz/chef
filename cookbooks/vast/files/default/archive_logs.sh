#!/bin/bash
FILES=$(find /data/apps/tomcat7/logs -name 'localhost_access_log*' -mtime +1)
cd /data/apps/tomcat7/logs
tar czpf localhost.access.log.archive.$(date +%s).tar.gz $FILES
find /data/apps/tomcat7/logs -name 'localhost_access_log*' -mtime +10 -exec rm {} \;
