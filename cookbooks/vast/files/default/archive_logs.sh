#!/bin/bash
# #########################################
# @FILE archive_logs.sh
# @AUTHOR Gregory Patmore
# @CONTACT gregorypatmore@clearchannel.com
# @DESC Script to manage localhost_access_log files for vast. archiving recent past files, and deleting older out of date archive files.
#
# #########################################
FILES=$(find /data/apps/tomcat7/logs -name 'localhost_access_log.*-*-*.txt' -mtime +1)
echo "INFO: [$(date)] $0 : Targetting (${#FILES[@]}) files for compression";

pushd /data/apps/tomcat7/logs
for f in ${FILES}; do
	# tar up each file 
	tar czvpf $f.tar.gz $f;

	# verify the file exists and, if so, remove the log file. else complain
	[[ $? -eq 0 ]] \
		&& ( [[ -f $f.tar.gz ]] && rm -fv $f ) \
		|| echo "Error: [$(date)] $0 : Failed to compress file ($f)" >&2;
done;
popd #/data/apps/tomcat7/logs

REMOVE=$(find /data/apps/tomcat7/logs -name 'localhost_access_log.*-*-*.txt*.gz' -mtime +10);
echo "INFO: [$(date)] $0 : Targetting (${#REMOVE[@]}) compressed files for deletion";

for f in ${REMOVE}; do
	rm -fv $f
done;